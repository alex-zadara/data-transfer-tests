#!/usr/bin/perl

# A random RAW test
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

my $iters_nr = 1000;
my $rd_ratio = 50;
my $rand_ratio = 30;
my $clean = 0;
my $rverify = 0;

my $min_IO_size = undef;
my $max_IO_size = undef;
my $signature_period = 0;
my $timestamps = 0;
my $min_skip_size = 0;
my $max_skip_size = 0;

my $conc_wr_nr = 10;
my $conc_rd_nr = 10;

my $const = 0;
my $seed = undef;

my $verbose = 0;

my $delete_log_file = 0;

my $rc = GetOptions("test=s" => \$test,
                    "loops_nr=i" => \$loops_nr,
                    "raw_dev_file=s" => \$raw_dev_file,
                    "start_sector=i" => \$start_sector,
                    "end_sector=s" => \$end_sector,
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
                    "delete_log_file" => \$delete_log_file);
if (!$rc || !dt_are_all_defined($test, $raw_dev_file, $start_sector, $min_IO_size, $max_IO_size, $seed)) {
	dt_utils_print_error("Missing or bad parameters\n");
	exit(1);
}

my $cmd = "-test $test -progr 1 -verb $verbose -loops $loops_nr";

my $log_filename = dt_create_log_filename(".", $test);
$cmd .= " -log_file " . $log_filename;

$cmd .= " -target " . dt_os_get_DataTransfer_RAW_target_name() . " " . $raw_dev_file . " " . $start_sector . " " . $end_sector;
$cmd .= " -noRAWcache 1";
$cmd .= " -init 1 -iters $iters_nr -rd_ratio $rd_ratio -rand $rand_ratio -clean $clean -rverify $rverify";
$cmd .= " -IO_size $min_IO_size $max_IO_size -skip_size $min_skip_size $max_skip_size -sgntr_prd $signature_period -ts_in_sgntr $timestamps";
# These parameters are relevant for AsyncRand test, they are ignored by SyncRand
$cmd .= " -conc_wr_nr $conc_wr_nr -conc_rd_nr $conc_rd_nr";
$cmd .= " -seed $seed -const $const";

dt_utils_print("Running DataTransfer...\n");

$rc = dt_run_DataTransfer($cmd);
if (!$rc) {
    exit(1);
}

if ($delete_log_file) {
    dt_utils_print("Deleting log file...\n");
    
    dt_delete_file($log_filename);
}


