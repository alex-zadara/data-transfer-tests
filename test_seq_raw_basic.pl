#!/usr/bin/perl

# A basic RAW test
# Writes some RAW data, then verifies it 

use warnings;
use strict;

use dt_utils;
use dt_os;
use dt_test;

use File::Spec;
use Getopt::Long;

# Test parameters ##################
my $test = undef;
my $loops_nr = 1;

my $raw_dev_file = undef;
my $start_sector = undef;
my $end_sector = "end";

my $IO_size = undef;
my $signature_period = 0;
my $timestamps = 0; # No timestamps by default
my $skip_size = 0;

my $const = 0;
my $seed = undef;

my $read = 0;
my $write = 0;

my $concurrent_requests_nr = 10;

my $verbose = 0;

my $delete_log_file = 0;

my $rc = GetOptions("test=s" => \$test,
                    "loops_nr=i" => \$loops_nr,
                    "raw_dev_file=s" => \$raw_dev_file,
                    "start_sector=i" => \$start_sector,
                    "end_sector=s" => \$end_sector,
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
                    "delete_log_file" => \$delete_log_file);
if (!$rc || !dt_are_all_defined($test, $raw_dev_file, $start_sector, $IO_size, $seed)) {
	dt_utils_print_error("Missing or bad parameters\n");
	exit(1);
}

my $cmd = "-test $test -progr 1 -verb $verbose -loops $loops_nr";

my $log_filename = dt_create_log_filename(".", $test);
$cmd .= " -log_file " . $log_filename;

$cmd .= " -target " . dt_os_get_DataTransfer_RAW_target_name() . " " . $raw_dev_file . " " . $start_sector . " " . $end_sector;
$cmd .= " -noRAWcache 1"; # Disable RAW caching
$cmd .= " -IO_size $IO_size -skip_size $skip_size -sgntr_prd $signature_period -ts_in_sgntr $timestamps";
$cmd .= " -seed $seed -const $const -write $write -read $read";

# These parameters are relevant for AsyncSeq test, they are ignored by SyncSeq
$cmd .= " -conc_req $concurrent_requests_nr -dm_rd_ratio 50";

dt_utils_print("Running DataTransfer...\n");

$rc = dt_run_DataTransfer($cmd);
if (!$rc) {
    exit(1);
}

if ($delete_log_file) {
    dt_utils_print("Deleting log file...\n");
    
    dt_delete_file($log_filename);
}
