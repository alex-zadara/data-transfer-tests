#!/usr/bin/perl

use warnings;
use strict;

sub dt_os_get_DataTransfer_path {
    return "..\\data-transfer\\DataTransfer.exe";
}

sub dt_os_get_DataTransfer_RAW_target_name {
    return "WIN_DISK_NUM";
}

sub dt_os_get_diff_path {
	return "diff";
}

# must return '1', since this file is being 'use'-ed.
1;
