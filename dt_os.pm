#!/usr/bin/perl

use warnings;
use strict;

# Module variables ###########################
my $OS = $^O;

require "dt_os_${OS}.pm";

# Private functions ###########################################
sub dt_os_init {
	dt_utils_print("Current operating system - '$OS'\n");
}

dt_os_init();

# End of private functions ######################################

# Exposed functions ######################################
# actually perform the execution of the given command in the shell.
# @param exec_err_str_ref - reference to a string in which an error message
#                           will be stored by the function, in case there
#                           was an error.
# @param cmd - the command to execute.
# @return true on success, false on failure.
sub dt_os_do_exec {
	my $exec_err_str_ref = $_[0];
    my $cmd = $_[1];

	my $rc = system($cmd);
	my $system_ret = $?;
	
	if ($rc == -1) {
	    #Failed to start the program - inspect $! for a reason
		$$exec_err_str_ref = "Failed to start the program - $!";
		return;
	}

	my $exit_signal = $system_ret & 127;
	if ($exit_signal) {
		$$exec_err_str_ref = "Got signal $exit_signal";
		return;
	}
	
	my $exit_status = $system_ret >> 8;
	if ($exit_status) {
		$$exec_err_str_ref = "Exit code: $exit_status";
		return;
	}

	return 1;
}

# execute the given command in the shell.
# print an error message to stderr on failure
# @return true on success, false on failure.
sub dt_os_exec {
	my $cmd = $_[0];
	
	my $rc = undef;
    my $exec_err_str = undef;
    
    $rc = dt_os_do_exec(\$exec_err_str, $cmd);

	if (!$rc) {
		dt_utils_print_error("dt_os_exec: system('$cmd') failed - $exec_err_str\n");
		return;
	}

	return 1;
}

# must return '1', since this file is being 'use'-ed.
1;

