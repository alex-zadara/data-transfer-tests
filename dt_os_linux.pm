#!/usr/bin/perl

# library used for perform operating-system specific operations -
# implementation for Linux.

use warnings;
use strict;

use dt_os_unix;

sub dt_os_get_DataTransfer_path { 
    my $is_raw = $_[0];
    
	return "/home/alyakas/bin/DataTransfer";
}

# must return '1', since this file is being 'use'-ed.
1;

