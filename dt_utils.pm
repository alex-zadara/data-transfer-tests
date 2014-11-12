#!/usr/bin/perl

# library used for general-purpose utility routines, which are not specific
# for testing.

use warnings;
use strict;

# Module variables ######################################################

my @dt_utils_MONTHS = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

# Subroutines ###########################################################3

# returns the current time in printable 'HH MM SS' format,
# separated by the specified separator
sub dt_utils_format_now {
	my $sep = $_[0];
	
	my ($time) = time();
	my ($sec, $min, $hour, $day_of_month, $month, $year) = localtime($time);
	
	my ($time_formated) = sprintf("%d$sep$day_of_month$sep%s$sep%2.2d$sep%2.2d$sep%2.2d",
	                              $year + 1900, $dt_utils_MONTHS[$month],
								  $hour, $min, $sec);

	return $time_formated;
}

sub dt_utils_format_elapsed_time {
	my ($time) = $_[0];

	my ($time_hour) = int($time / 3600);
	my ($time_min) = int(($time - $time_hour * 3600) / 60);
	my ($time_sec) = $time - $time_hour * 3600 - $time_min * 60;

	my ($time_formated) = sprintf("%2.2d:%2.2d:%2.2d",
				                  $time_hour, $time_min, $time_sec);

	return $time_formated;
}

# prints a message or a list of messages to STDOUT, with a time-stamp prefix,
# and flushes it on-the-spot..
sub dt_utils_print {
	my (@msgs) = @_;
	my ($now) = dt_utils_format_now(":");

	my ($former_flush) = $|;
	$| = 1; # Setting this to non-zero, forces flush right away
	print "[$now] ", @msgs;
	$| = $former_flush;
}

sub dt_utils_print_no_time {
	my (@msgs) = @_;

	my ($former_flush) = $|;
	$| = 1; # Setting this to non-zero, forces flush right away
	print @msgs;
	$| = $former_flush;
}


sub dt_utils_print_error {
	my (@msgs) = @_;
	my ($now) = dt_utils_format_now(":");

	my ($former_flush) = $|;
	$| = 1; # Setting this to non-zero, forces flush right away
	print STDERR "[$now] ERROR: ", @msgs;
	$| = $former_flush;
}

# Removes trailing and leading whitespaces (including trailing newline)
#    from the supplied string.
# @return the trimmed string
sub dt_utils_trim {
    my $str = $_[0];

    # Quite a clever match pattern, don't you think?    
    if ($str =~ /^\s*(\S.*?)\s*$/) {
        return $1;
    }
    
    return ''; # Empty string
}

sub dt_are_all_defined {
	my @params = @_;
	my $param_i = 0;
	
	for ($param_i = 0; $param_i < scalar(@params); ++$param_i) {
		if (!defined($params[$param_i])) {
			return;
		}
	}
	
	return 1;
}	

# must return '1', since this file is being 'use'-ed.
1;

