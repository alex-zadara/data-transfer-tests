#!/usr/bin/perl

# runs a list of tests. reports success/failure state for each test on a single line.
# run_tests.pl --suite=suites/suite_volume_tiny.pl --test=2 --repeat=1 --verbose --attr timestamps=0

use warnings;
use strict;

use dt_utils;
use dt_os;

use Getopt::Long;
use File::Spec;

# The attributes hash allows parameterization of the test suites.
# An attribute has a name and a value
%main::attr = ();

my ($suite) = undef; # the name of the suite to load - MANDATORY
my ($test_num) = undef; # The number of test in a suite (starting from 1) or 'all' - MANDATORY
my ($repeat) = -1; # How many times to run the test (0 for infinite)
my $verbose = 0;

my($rc) = GetOptions("suite=s" => \$suite,
	 	             "test=s" => \$test_num,
	 	             "repeat=i" => \$repeat,
	 	             "verbose" => \$verbose,
					 "attr=s" => \%main::attr);
if (!$rc || !dt_are_all_defined($suite, $test_num)) {
	dt_utils_print_error("Missing or bad parameters\n");
	exit(1);
}

# @main::tests is an array of anonymous hash references
# Each hash contains 3 pairs, identified by keys 'name', 'script' and 'params'.
# 'name' defines the name of the test, 'script' defines the Perl script that contains
# the test, 'params' defines command-line parameters for the script
@main::tests = (); 
# Main tests is now filled from the selected suite
require File::Spec->catfile(".", $suite);

if ($test_num eq 'all') {
	# Do nothing, just check that $test_num is valid
} elsif ($test_num >= 1 && $test_num <= scalar(@main::tests)) {
	@main::tests = ($main::tests[$test_num - 1]);
} else {
	dt_utils_print_error("Illegal test number '$test_num'\n");
	exit(1);
}

run_tests(\@main::tests, $repeat, $verbose);

sub run_tests {
    my ($tests_ref, $repeat, $verbose) = @_;
    
    my $test_idx = 0;	    
    my ($iteration) = 1;

    # this label is for handling repeating test(s) iterations.
    while (1) {
        if ($repeat == 0) {
            dt_utils_print("ITERATION $iteration (repeat == infinite):\n");
        } elsif ($repeat > 0) {
            dt_utils_print("ITERATION $iteration (of $repeat):\n");
        }
        
        for ($test_idx = 0; $test_idx < scalar(@$tests_ref); ++$test_idx) {
        	if (!run_test($tests_ref->[$test_idx], $test_idx + 1, $verbose)) {
        	    last;
        	}
        }
        
        if ($repeat == -1) {
            last;
        }
        
        ++$iteration;
        if ($repeat > 0 && $iteration > $repeat) {
            last;
        }
    }
}

sub run_test {
	my $test_ref = $_[0];
	my $test_num = $_[1];
	my $verbose = $_[2];
	
	my $cmd = "perl " . $test_ref->{script} . " " . $test_ref->{params};
	
	my $test_output_file = undef;
	if (!$verbose) {
		$test_output_file = File::Spec->catfile(File::Spec->curdir(), ('test_output_' . $$ . '.txt'));
		$cmd .= " > $test_output_file 2>&1";
	}
		 
	my $test_name = $test_ref->{name};
	
	my ($test_dots) = '.' x (60 - length($test_name));
	dt_utils_print("RUNNING TEST No. $test_num\n$test_name" .  $test_dots . ":  ");
	
	# execute the test.
	my $time_before = time();
	my $exec_err_str = undef;
	my $test_rc = dt_os_do_exec(\$exec_err_str, $cmd);
	my ($time_formated) = dt_utils_format_elapsed_time(time() - $time_before);
	
	# checking test results...
	if ($test_rc) {
		dt_utils_print_no_time("OK  [elapsed test time: ${time_formated}]\n");
	} else {
		dt_utils_print_no_time("ERROR  [elapsed test time: ${time_formated}]\n");
		dt_utils_print "run_test: dt_os_do_exec() failed - $exec_err_str\n";
		if (!$verbose) {
			emit_test_output($test_output_file);
		}
	}
	
	if (!$verbose) {
	   unlink($test_output_file);
	}
	
	return $test_rc;
}	

sub emit_test_output {
    my ($test_output_file) = @_;
    
	dt_utils_print_no_time("    ERRORS:\n    ===============================\n");

    my (@test_output) = ();
    read_test_output_file($test_output_file, \@test_output);
    foreach my $line (@test_output) {
	    print(STDERR $line);
    }
    dt_utils_print_no_time("===============================\n    END ERRORS\n");
}

# read a test output file into memory.
# supplies its contents in the given array on success, or a single error
# line on failure to read the file.
sub read_test_output_file {
    my ($test_output_file, $test_output_ref) = @_;
    my ($test_fh);

    # we use static handles, rather then dynamic, to cope with older perl
    # versions.
    if (open(TESTOUTFH, "<${test_output_file}")) {
        @$test_output_ref = <TESTOUTFH>;
        close(TESTOUTFH);
    }
    else {
        push(@$test_output_ref, "read_test_output_file: failed opening test output file '$test_output_file' - $!\n");
    }
}


