#!/usr/bin/perl

# A random file-system test

use warnings;
use strict;

use dt_utils;
use dt_os;
use dt_test;

use File::Spec;
use Getopt::Long;

Getopt::Long::Configure("pass_through");

# Test parameters ##################
my $test = undef;
my $dest_dir = undef;
my $test_file_prefix = "testfile";
my $correct_file_prefix = "correctfile";
my $loops_nr = 1;

my $total_space_MB = undef;
my $files_nr = undef;

my $iters_nr = 1000;
my $rd_ratio = 50;
my $rand_ratio = 30;
my $clean = 0;
my $rverify = 0;

my $min_IO_size = undef;
my $max_IO_size = undef;
my $signature_period = 0;
my $timestamps = 0; # No timestamps by default
my $min_skip_size = 0;
my $max_skip_size = 0;

my $conc_wr_nr = 10;
my $conc_rd_nr = 10;

my $const = 0;
my $seed = undef;

my $verbose = 0;

my $perform_diff = 0;
my $delete_test_files = 0;
my $delete_log_file = 0;

my $rc = GetOptions("test=s" => \$test,
                    "dest_dir=s" => \$dest_dir,
                    "test_file_prefix=s" => \$test_file_prefix,
                    "correct_file_prefix=s" => \$correct_file_prefix,
                    "loops_nr=i" => \$loops_nr,
                    "total_space_MB=i" => \$total_space_MB,
                    "files_nr=i" => \$files_nr,
                    "iters_nr=i" => \$iters_nr,
                    "rd_ratio=i" => \$rd_ratio,
                    "rand_ratio=i" => \$rand_ratio,
                    "clean" => \$clean,
                    "rverify" => \$rverify,
                    "min_IO_size=i" => \$min_IO_size,
                    "max_IO_size=i" => \$max_IO_size,
                    "signature_period=i" => \$signature_period,
                    "timestamps" => \$timestamps,
                    "min_skip_size=i" => \$min_skip_size,
                    "max_skip_size=i" => \$max_skip_size,
                    "conc_wr_nr=i" => \$conc_wr_nr,
                    "conc_rd_nr=i" => \$conc_rd_nr,
                    "const" => \$const,
                    "seed=s" => \$seed,
					"verbose" => \$verbose,
					"perform_diff" => \$perform_diff,
                    "delete_test_files" => \$delete_test_files,
                    "delete_log_file" => \$delete_log_file);
if (!$rc || !dt_are_all_defined($test, $dest_dir, $total_space_MB, $files_nr, $min_IO_size, $max_IO_size, $seed)) {
	dt_utils_print_error("Missing or bad parameters\n");
	exit(1);
}

my $cmd = "-test $test -progr 1 -verb $verbose -loops $loops_nr";

my $log_filename = dt_create_log_filename($dest_dir, $test);
$cmd .= " -log_file " . $log_filename;

$cmd .= " -target FS " . File::Spec->catfile($dest_dir, $test_file_prefix) . " $total_space_MB $files_nr";
$cmd .= " -init 1 -iters $iters_nr";
$cmd .= " -rd_ratio $rd_ratio -rand $rand_ratio -clean $clean -rverify $rverify";
$cmd .= " -IO_size $min_IO_size $max_IO_size -skip_size $min_skip_size $max_skip_size -sgntr_prd $signature_period -ts_in_sgntr $timestamps";
# These parameters are relevant for AsyncRand test, they are ignored by SyncRand
$cmd .= " -conc_wr_nr $conc_wr_nr -conc_rd_nr $conc_rd_nr";
$cmd .= " -seed $seed -const $const";

dt_utils_print("Running DataTransfer...\n");

$rc = dt_run_DataTransfer($cmd);
if (!$rc) {
    exit(1);
}

if ($perform_diff) {
    dt_utils_print("diffing test files...\n");
    
    if (!dt_compare_test_files(File::Spec->catfile($dest_dir, $correct_file_prefix),
                               File::Spec->catfile($dest_dir, $test_file_prefix),
                               $files_nr)) {
	   exit(1);
	}
}

if ($delete_test_files) {
    dt_utils_print("Deleting test files...\n");
    
    dt_delete_test_files(File::Spec->catfile($dest_dir, $test_file_prefix), $files_nr);
}

if ($delete_log_file) {
    dt_utils_print("Deleting log file...\n");
    
    dt_delete_file($log_filename);
}

exit(0);
