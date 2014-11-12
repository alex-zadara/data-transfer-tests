#!/usr/bin/perl

use warnings;
use strict;

if (!defined($main::attr{loops_nr})) {
    $main::attr{loops_nr} = 3;
}
if (!defined($main::attr{conc_req_nr})) {
    $main::attr{conc_req_nr} = 10;
}

if (!defined($main::attr{timestamps})) {
    $main::attr{timestamps} = 0;
}

my $loops_nr = $main::attr{loops_nr};
my $conc_wr_nr = $main::attr{conc_req_nr};
my $conc_rd_nr = $main::attr{conc_req_nr};
my $timestamps   = ($main::attr{timestamps} == 0) ? "" : "--timestamps";

my $test_file_prefix = "testfile";
my $iters_nr = 100;

# the list of tests in this suite.
# This array contains a list of anonymous hash references
@main::tests = (
    { name => "AsyncRand FS - read-only, long sequences, mult. readers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=0 --rverify  --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=0 --conc_rd_nr=$conc_rd_nr --seed=0x11223344 --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-only, long sequences, single reader",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=0 --rverify  --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=0 --conc_rd_nr=1 --seed=0x11223345 --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "SyncRand FS - read-only, long sequences",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=0 --rverify  --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --seed=0x11223346 --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    ###############################
    
    { name => "AsyncRand FS - read-only, short sequences, mult. readers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=95 --rverify  --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=0 --conc_rd_nr=$conc_rd_nr --seed=0x11223347 --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-only, short sequences, single reader",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=95 --rverify  --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=0 --conc_rd_nr=1 --seed=0x11223348 --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "SyncRand FS - read-only, short sequences",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=100 --rand_ratio=95 --rverify  --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --seed=0x11223349 --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    ########################################3
    { name => "AsyncRand FS - write-only, long sequences, mult. writers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - write-only, long sequences, mult. writers, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x1122334B --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - write-only, long sequences, single writer",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=1 --seed=0x1122334C --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - write-only, long sequences, single writer, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=1 --const --seed=0x1122334D --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "SyncRand FS - write-only, long sequences",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "SyncRand FS - write-only, long sequences, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=0 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    ################################
    { name => "AsyncRand FS - write-only, short sequences, mult. writers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - write-only, short sequences, mult. writers, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x1122334B --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - write-only, short sequences, single writer",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=1 --seed=0x1122334C --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - write-only, short sequences, single writer, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=1 --const --seed=0x1122334D --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "SyncRand FS - write-only, short sequences",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "SyncRand FS - write-only, short sequences, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=0 --rand_ratio=95 --clean --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    ##################################################################
    { name => "AsyncRand FS - read-write, long sequences, mult. writers, single reader",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, long sequences, mult. writers, mult. readers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, long sequences, single writer, mult. readers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - read-write, long sequences, mult. writers, single reader, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, long sequences, mult. writers, mult. readers, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, long sequences, single writer, mult. readers, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "SyncRand FS - read-write, long sequences",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "SyncRand FS - read-write, long sequences, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=0 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    #####################################################################33
    { name => "AsyncRand FS - read-write, short sequences, mult. writers, single reader",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, short sequences, mult. writers, mult. readers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, short sequences, single writer, mult. readers",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "AsyncRand FS - read-write, short sequences, mult. writers, single reader, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=1 --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, short sequences, mult. writers, mult. readers, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=$conc_wr_nr --conc_rd_nr=$conc_rd_nr --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    
    { name => "AsyncRand FS - read-write, short sequences, single writer, mult. readers, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=AsyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --conc_wr_nr=1 --conc_rd_nr=$conc_rd_nr --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "SyncRand FS - read-write, short sequences",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },

    { name => "SyncRand FS - read-write, short sequences, const data",
      script => 'test_rand_fs_basic.pl',
      params => "--test=SyncRand --dest_dir=rand_clean_data --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --iters_nr=$iters_nr --rd_ratio=50 --rand_ratio=95 --clean --rverify --min_IO_size=500 --max_IO_size=713 --min_skip_size=8765 --max_skip_size=8766 --const --seed=0x1122334A --perform_diff --delete_test_files --delete_log_file $timestamps"
    },
    

);

1;



