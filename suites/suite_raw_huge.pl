#!/usr/bin/perl

use warnings;
use strict;

if (!defined($main::attr{loops_nr})) {
    $main::attr{loops_nr} = 3;
}
if (!defined($main::attr{conc_req_nr})) {
    $main::attr{conc_req_nr} = 50;
}
if (!defined($main::attr{raw_dev_file})) {
    $main::attr{raw_dev_file} = "2";
}
if (!defined($main::attr{timestamps})) {
    $main::attr{timestamps} = 0;
}

my $loops_nr = $main::attr{loops_nr};
my $concurr_requests_nr = $main::attr{conc_req_nr};
my $raw_dev_file = $main::attr{raw_dev_file};
my $timestamps = ($main::attr{timestamps} == 0) ? "" : "--timestamps";

# the list of tests in this suite.
# This array contains a list of anonymous hash references
@main::tests = (
    { name => "AsyncSeq RAW - huge",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=0 --end_sector=end --IO_size=600233 --signature_period=2345 --skip_size=3401 --seed=0x92837465 --read --write --conc_req_nr=$concurr_requests_nr $timestamps"
    },
    
    { name => "SyncSeq RAW - huge",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=0 --end_sector=end --IO_size=600233 --signature_period=2345 --skip_size=3401 --seed=0xAA23BBCC76 --read --write $timestamps"
    },
    
    { name => "SyncRand RAW - huge",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=0 --end_sector=end --iters_nr=10000 --clean --rverify --min_IO_size=487344 --max_IO_size=765443 --signature_period=512 --min_skip_size=689000 --max_skip_size=800021 --seed=0xAADDEEFF"
    },
    
    { name => "AsyncRand RAW - huge",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=0 --end_sector=end --iters_nr=10000 --clean --rverify --min_IO_size=487344 --max_IO_size=765443 --signature_period=512 --min_skip_size=689000 --max_skip_size=800021 --conc_wr_nr=$concurr_requests_nr --conc_rd_nr=$concurr_requests_nr --seed=0xAACCFFEE"
    }
);

1;



