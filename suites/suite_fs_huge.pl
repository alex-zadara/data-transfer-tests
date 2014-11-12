#!/usr/bin/perl

use warnings;
use strict;

if (!defined($main::attr{loops_nr})) {
    $main::attr{loops_nr} = 2;
}
if (!defined($main::attr{conc_req_nr})) {
    $main::attr{conc_req_nr} = 50;
}
if (!defined($main::attr{dest_dir})) {
    $main::attr{dest_dir} = "H:\\";
}

my $loops_nr = $main::attr{loops_nr};
my $concurr_requests_nr = $main::attr{conc_req_nr};
my $dest_dir = $main::attr{dest_dir};

my $read = 1;
my $write= 1;
my $test_file_prefix = "testfile";

@main::tests = (
    { name => "AsyncSeq FS - huge",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=$dest_dir --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=17000 --files_nr=4 --IO_size=600233 --signature_period=51204 --skip_size=3401 --seed=0xDDD3154F --read --write --conc_req_nr=$concurr_requests_nr"
    },
    { name => "SyncSeq FS - huge",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=$dest_dir --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=17000 --files_nr=4 --IO_size=600233 --signature_period=51201 --skip_size=3401 --seed=0xFFFE3A20 --read --write"
    },
    
    { name => "SyncRand FS - huge",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=$dest_dir --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=17000 --files_nr=4 --iters_nr=10000 --clean --rverify --min_IO_size=487344 --max_IO_size=765443 --signature_period=237 --min_skip_size=689000 --max_skip_size=800021  --seed=0x12348765"
    },

    { name => "AsyncRand FS - huge",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=$dest_dir --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=17000 --files_nr=4 --iters_nr=10000 --clean --rverify --min_IO_size=487344 --max_IO_size=765443 --signature_period=237 --min_skip_size=689000 --max_skip_size=800021 --conc_wr_nr=$concurr_requests_nr --conc_rd_nr=$concurr_requests_nr --seed=0xDDFFB123" 
    }
      
);

1;
