#!/usr/bin/perl

use warnings;
use strict;

if (!defined($main::attr{loops_nr})) {
    $main::attr{loops_nr} = 2;
}
if (!defined($main::attr{conc_req_nr})) {
    $main::attr{conc_req_nr} = 10;
}
if (!defined($main::attr{raw_dev_file})) {
    $main::attr{raw_dev_file} = "2";
}
if (!defined($main::attr{start_sector})) {
    $main::attr{start_sector} = 30000000;
}

my $loops_nr = $main::attr{loops_nr};
my $conc_wr_nr = $main::attr{conc_req_nr};
my $conc_rd_nr = $main::attr{conc_req_nr};
my $raw_dev_file = $main::attr{raw_dev_file};
my $start_sector = $main::attr{start_sector};

my $iters_nr = 100;

# the list of tests in this suite.
# This array contains a list of anonymous hash references
@main::tests = (
    { name => "SyncSeq RAW - clean",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector - 1000) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512343 --skip_size=0 --const --seed=0xFFFFFFFF --read --write --delete_log_file" 
    },
    
    ###################################3
    { name => "AsyncRand RAW - read-only, long sequences, mult. readers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=0 --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=0 --conc_rd_nr=$conc_rd_nr --seed=0x87654321 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-only, long sequences, single reader",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=0 --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=0 --conc_rd_nr=1 --seed=0x87654322 --delete_log_file"
    },
    
    { name => "SyncRand RAW - read-only, long sequences",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=0 --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --seed=0x87654323 --delete_log_file"
    },
    
    { name => "AsyncSeq - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1001) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512000 --const --seed=0xFFFFFFFF --read --conc_req_nr=1 --delete_log_file"
    },
   
    ######## 
    { name => "AsyncRand RAW - read-only, short sequences, mult. readers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=95 --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=0 --conc_rd_nr=$conc_rd_nr --seed=0x87654324 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-only, short sequences, single reader",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=95 --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=0 --conc_rd_nr=1 --seed=0x87654325 --delete_log_file"
    },
    
    { name => "SyncRand RAW - read-only, short sequences",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=95 --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --seed=0x87654326 --delete_log_file"
    },
    
    { name => "AsyncSeq - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1001) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512000 --const --seed=0xFFFFFFFF --read --conc_req_nr=1 --delete_log_file"
    },
    
    ######################################
    { name => "AsyncRand RAW - write-only, long sequences, mult. writers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x87654327 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - write-only, long sequences, mult. writers, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x87654328 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - write-only, long sequences, single writer",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=1 --seed=0x87654329 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - write-only, long sequences, single writer, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=1 --const --seed=0x8765432A --delete_log_file"
    },
    
    { name => "SyncRand RAW - write-only, long sequences",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --seed=0x8765432B --delete_log_file"
    },
    
    { name => "SyncRand RAW - write-only, long sequences, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --const --seed=0x8765432C --delete_log_file"
    },
    
    { name => "AsyncSeq - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1001) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512000 --const --seed=0xFFFFFFFF --read --conc_req_nr=1 --delete_log_file"
    },
    
    #########
    { name => "AsyncRand RAW - write-only, short sequences, mult. writers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x8765432D --delete_log_file"
    },
    
    { name => "AsyncRand RAW - write-only, short sequences, mult. writers, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x8765432E --delete_log_file"
    },
    
    { name => "AsyncRand RAW - write-only, short sequences, single writer",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=1 --seed=0x8765432F --delete_log_file"
    },
    
    { name => "AsyncRand RAW - write-only, short sequences, single writer, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=1 --const --seed=0x87654330 --delete_log_file"
    },
    
    { name => "SyncRand RAW - write-only, short sequences",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --seed=0x87654331 --delete_log_file"
    },
    
    { name => "SyncRand RAW - write-only, short sequences, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --const --seed=0x87654332 --delete_log_file"
    },
    
    { name => "AsyncSeq - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1001) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512000 --const --seed=0xFFFFFFFF --read --conc_req_nr=1 --delete_log_file"
    },
    #####################
    
    { name => "AsyncRand RAW - read-write, long sequences, mult. writers, single reader",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x87654333 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, long sequences, mult. writers, multiple readers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --seed=0x87654334 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, long sequences, single writer, mult. readers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --seed=0x87654335 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, long sequences, mult. writers, single reader, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x87654336 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, long sequences, mult. writers, multiple readers, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --const --seed=0x87654337 --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, long sequences, single writer, mult. readers, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --const --seed=0x87654338 --delete_log_file"
    },
    
    { name => "SyncRand RAW - read-write, long sequences",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --seed=0x87654339 --delete_log_file"
    },
    
    { name => "SyncRand RAW - read-write, long sequences, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --const --seed=0x8765433A --delete_log_file"
    },
    
    { name => "AsyncSeq - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1001) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512000 --const --seed=0xFFFFFFFF --read --conc_req_nr=1 --delete_log_file"
    },
    
    #######################    
    { name => "AsyncRand RAW - read-write, short sequences, mult. writers, single reader",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x8765433B --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, short sequences, mult. writers, multiple readers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --seed=0x8765433C --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, short sequences, single writer, mult. readers",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --seed=0x8765433D --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, short sequences, mult. writers, single reader, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x8765433E --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, short sequences, mult. writers, multiple readers, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --const --seed=0x8765433F --delete_log_file"
    },
    
    { name => "AsyncRand RAW - read-write, short sequences, single writer, mult. readers, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=AsyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --const --seed=0x87654340 --delete_log_file"
    },
    
    { name => "SyncRand RAW - read-write, short sequences",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --seed=0x87654341 --delete_log_file"
    },
    
    { name => "SyncRand RAW - read-write, short sequences, const data",
      script => 'test_rand_raw_basic.pl',
      params => "--test=SyncRand --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1000) . " --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=1600 --max_IO_size=10240 --signature_period=512 --min_skip_size=0 --max_skip_size=0 --const --seed=0x87654342 --delete_log_file"
    },
    
    { name => "AsyncSeq - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1001) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512000 --const --seed=0xFFFFFFFF --read --conc_req_nr=1 --delete_log_file"
    },
    
	#######################
	
    { name => "SyncSeq RAW - checking that there is no underflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector - 1000) . " --end_sector=" . ($start_sector - 1) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file"
    },
);

1;
