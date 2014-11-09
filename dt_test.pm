#!/usr/bin/perl

use warnings;
use strict;

use dt_os;

use File::Spec;

my $DATA_TRANSFER_TEST_FILES_EXT = ".din";

sub dt_run_DataTransfer {
	my $cmd = $_[0];
	
	$cmd = dt_os_get_DataTransfer_path() . " " . $cmd;
	
	return dt_os_exec($cmd);
}

sub dt_create_log_filename {
	my $dest_dir = $_[0];
	my $test_name = $_[1];
	
	return File::Spec->catfile($dest_dir, ($test_name . "_" . dt_utils_format_now("_") . ".log"));
}

sub dt_create_test_filename {
	my $prefix = $_[0];
	my $file_idx = $_[1];
	
	return $prefix . $file_idx . $DATA_TRANSFER_TEST_FILES_EXT;
} 

sub dt_compare_test_files {
	my $correct_files_prefix = $_[0];
	my $test_files_prefix = $_[1];
	my $files_nr = $_[2];
	my $file_i = 0;
	my $rc = 1;
	
	for ($file_i = 0; $file_i < $files_nr; ++$file_i) {
		my $correct_filename = dt_create_test_filename($correct_files_prefix, $file_i);
		my $test_filename = dt_create_test_filename($test_files_prefix, $file_i);
		my $cmd = undef;
		
		if (! (-e $correct_filename)) {
		    $rc = 0;
		    dt_utils_print_error("dt_compare_test_files: Correct file '$correct_filename' does not exist, moving on...\n");
		    next;
		}
		if (! (-e $test_filename)) {
		    $rc = 0;
		    dt_utils_print_error("dt_compare_test_files: Test file '$test_filename' does not exist, moving on...\n");
		    next;
		}

		$cmd = dt_os_get_diff_path() . " " . $correct_filename . " " . $test_filename;
		if (!dt_os_exec($cmd)) {
		    $rc = 0;
		}
	}
	
	if (!$rc) {
	    return;
	}
	
	return 1;
}	

sub dt_delete_test_files {
	my $file_prefix = $_[0];
	my $files_nr = $_[1];
	
	my $file_i = 0;
	
	for ($file_i = 0; $file_i < $files_nr; ++$file_i) {
		my $filename = dt_create_test_filename($file_prefix, $file_i);
		
		if (! (-e $filename)) {
			next;
		}
		
		if (unlink($filename) != 1) {
			dt_utils_print_error("dt_delete_test_files: Failed deleting '$filename', moving on...\n");
		}
	}
}

sub dt_delete_file {
	my $filename = $_[0];

	if (unlink($filename) != 1) {
		dt_utils_print_error("dt_delete_file: Failed deleting '$filename'\n");
	}
}
