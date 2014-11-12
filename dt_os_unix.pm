#!/usr/bin/perl

use warnings;
use strict;

sub dt_os_get_DataTransfer_RAW_target_name {
    return "UNIX_DEVICE";
}

sub dt_os_get_diff_path {
	return "diff";
}

# must return '1', since this file is being 'use'-ed.
1;
