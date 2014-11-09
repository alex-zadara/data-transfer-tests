#!/usr/bin/perl

# A basic file-system test
# Writes files, reads then, then diffs the files with the correct files

use warnings;
use strict;

use dt_utils;
use dt_os;
use dt_test;

use File::Spec;
use Getopt::Long;

# Test parameters ##################
my $test = undef;
my $dest_dir = undef;
my $correct_file_prefix = "correctfile";
my $test_file_prefix = "testfile";
my $loops_nr = 1;
my $total_space_MB = undef;
my $files_nr = undef;
my $IO_size = undef;
my $signature_period = 0;
my $timestamps = 0;
my $skip_size = 0;
my $const = 0;
my $seed = undef;
my $read = 0;
my $write = 0;
my $concurrent_requests_nr = 10;
my $verbose = 0;
my $perform_diff = 0;
my $delete_test_files = 0;
my $delete_log_file = 0;

my $rc = GetOptions("test=s" => \$test,
                    "dest_dir=s" => \$dest_dir,
                    "correct_file_prefix=s" => \$correct_file_prefix,
                    "test_file_prefix=s" => \$test_file_prefix,
                    "loops_nr=i" => \$loops_nr,
                    "total_space_MB=i" => \$total_space_MB,
                    "files_nr=i" => \$files_nr,
                    "IO_size=i" => \$IO_size,
                    "signature_period=i" => \$signature_period,
                    "timestamps" => \$timestamps,
                    "skip_size=i" => \$skip_size,
                    "const" => \$const,
                    "seed=s" => \$seed,
					"read" => \$read,
					"write" => \$write,
					"conc_req_nr=i" => \$concurrent_requests_nr,
					"verbose" => \$verbose,
                    "perform_diff" => \$perform_diff,
                    "delete_test_files" => \$delete_test_files,
                    "delete_log_file" => \$delete_log_file);
if (!$rc || !dt_are_all_defined($test, $dest_dir, $total_space_MB, $files_nr, $IO_size, $seed) ||
    $concurrent_requests_nr == 0) {
	dt_utils_print_error("Missing or bad parameters\n");
	exit(1);
}

my $cmd = "-test $test -progr 1 -verb $verbose -loops $loops_nr -delay_loops 0";

my $log_filename = dt_create_log_filename($dest_dir, $test);
$cmd .= " -log_file " . $log_filename;

$cmd .= " -target FS " . File::Spec->catfile($dest_dir, $test_file_prefix) . " $total_space_MB $files_nr";
$cmd .= " -IO_size $IO_size -skip_size $skip_size -sgntr_prd $signature_period -ts_in_sgntr $timestamps";
$cmd .= " -seed $seed -const $const -write $write -read $read";

# These parameters are relevant for AsyncSeq test, they are ignored by SyncSeq
$cmd .= " -conc_req $concurrent_requests_nr -dm_rd_ratio 50";

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

if ($delete_test_files && $write) {
    dt_utils_print("Deleting test files...\n");
    
    dt_delete_test_files(File::Spec->catfile($dest_dir, $test_file_prefix), $files_nr);
}

if ($delete_log_file) {
    dt_utils_print("Deleting log file...\n");
    
    dt_delete_file($log_filename);
}

exit(0);
