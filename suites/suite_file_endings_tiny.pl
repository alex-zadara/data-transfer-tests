#!/usr/bin/perl

use warnings;
use strict;

if (!defined($main::attr{loops_nr})) {
    $main::attr{loops_nr} = 3;
}
if (!defined($main::attr{conc_req_nr})) {
    $main::attr{conc_req_nr} = 50;
}
if (!defined($main::attr{timestamps})) {
    $main::attr{timestamps} = 0;
}

my $loops_nr = $main::attr{loops_nr};
my $concurr_requests_nr = $main::attr{conc_req_nr};
my $timestamps   = ($main::attr{timestamps} == 0) ? "" : "--timestamps";
my $perform_diff = ($main::attr{timestamps} == 0) ? "--perform_diff" : "";

my $test_file_prefix = "testfile";

# the list of tests in this suite.
# This array contains a list of anonymous hash references
@main::tests = (
    { name => "AsyncSeq FS - IO size and skip size more than file size 1",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize1") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1041111 --signature_period=508 $timestamps --skip_size=2000000 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size and skip size more than file size 1",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize1") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1041111 --signature_period=508 $timestamps --skip_size=2000000 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },
    
    { name => "AsyncSeq FS - IO size and skip size more than file size 1 const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize1_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1041111 --signature_period=508 --skip_size=2000000 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file" 
    },
    { name => "SyncSeq FS - IO size and skip size more than file size 1 const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize1_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1041111 --signature_period=508 --skip_size=2000000 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },
    
    #############
    
    { name => "AsyncSeq FS - IO size and skip size more than file size 2",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize2") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048575 --signature_period=508 $timestamps --skip_size=2000000 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size and skip size more than file size 2",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize2") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048575 --signature_period=508 $timestamps --skip_size=2000000 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },
    
    { name => "AsyncSeq FS - IO size and skip size more than file size 2 const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize2_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048575 --signature_period=508 --skip_size=2000000 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size and skip size more than file size 2 const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_and_skip_size_more_than_filesize2_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048575 --signature_period=508 --skip_size=2000000 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },
   
    #######################
    
    { name => "AsyncSeq FS - IO size equals file size",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_equals_filesize") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048576 --signature_period=36 $timestamps --skip_size=276 --seed=0x87654321  --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size equals file size",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_equals_filesize") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048576 --signature_period=36 $timestamps --skip_size=276 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },
    
    { name => "AsyncSeq FS - IO size equals file size const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_equals_filesize_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048576 --signature_period=36 --skip_size=276 --const --seed=0x87654321  --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size equals file size const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_equals_filesize_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1048576 --signature_period=36 --skip_size=276 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },

	#######################    
    
    { name => "AsyncSeq FS - IO size more than file size",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_more_than_filesize") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1400213 --signature_period=36 $timestamps --skip_size=276 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size more than file size",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_more_than_filesize") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1400213 --signature_period=36 $timestamps --skip_size=276 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },
    
    { name => "AsyncSeq FS - IO size more than file size const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_more_than_filesize_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1400213 --signature_period=36 --skip_size=276 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - IO size more than file size const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_IO_size_more_than_filesize_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=5 --files_nr=5 --IO_size=1400213 --signature_period=36 --skip_size=276 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },

	####################

    { name => "AsyncSeq FS - last chunk full IO no skip",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_full_IO_no_skip") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=112 --signature_period=64 $timestamps --skip_size=64 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last chunk full IO no skip",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_full_IO_no_skip") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=112 --signature_period=64 $timestamps --skip_size=64 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },

    { name => "AsyncSeq FS - last chunk full IO no skip const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_full_IO_no_skip_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=112 --signature_period=64 --skip_size=64 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last chunk full IO no skip const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_full_IO_no_skip_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=112 --signature_period=64 --skip_size=64 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },
    
    ##########################
    
    { name => "AsyncSeq FS - last chunk partial IO",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_IO") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=160 --signature_period=64 $timestamps --skip_size=16 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last chunk partial IO",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_IO") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=160 --signature_period=64 $timestamps --skip_size=16 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },

    { name => "AsyncSeq FS - last chunk partial IO const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_IO_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=160 --signature_period=64 --skip_size=16 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last chunk partial IO const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq  --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_IO_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=160 --signature_period=64 --skip_size=16 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },

	##############################

    { name => "AsyncSeq FS - last chunk partial skip",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_skip") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=103 --signature_period=64 $timestamps --skip_size=73 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last chunk partial skip",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_skip") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=103 --signature_period=64 $timestamps --skip_size=73 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },

    { name => "AsyncSeq FS - last chunk partial skip const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_skip_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=103 --signature_period=64 --skip_size=73 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last chunk partial skip const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_chunk_partial_skip_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=2 --files_nr=5 --IO_size=103 --signature_period=64 --skip_size=73 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },
    
    ##############################
    
    { name => "AsyncSeq FS - last IO less than signature size",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_IO_less_than_sgntr") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=1 --files_nr=1 --IO_size=1048575 --signature_period=23456 $timestamps --skip_size=0 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr $perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last IO less than signature size",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_IO_less_than_sgntr") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=1 --files_nr=1 --IO_size=1048575 --signature_period=23456 $timestamps --skip_size=0 --seed=0x87654321 --read --write $perform_diff --delete_test_files --delete_log_file"
    },
    
    { name => "AsyncSeq FS - last IO less than signature size - const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=AsyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_IO_less_than_sgntr_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=1 --files_nr=1 --IO_size=1048575 --signature_period=23456 --skip_size=0 --const --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --perform_diff --delete_test_files --delete_log_file"
    },
    { name => "SyncSeq FS - last IO less than signature size - const data",
      script => 'test_seq_fs_basic.pl',
      params => "--test=SyncSeq --dest_dir=" . File::Spec->catdir(".", "fs_last_IO_less_than_sgntr_const") . " --test_file_prefix=$test_file_prefix --loops_nr=$loops_nr --total_space_MB=1 --files_nr=1 --IO_size=1048575 --signature_period=23456 --skip_size=0 --const --seed=0x87654321 --read --write --perform_diff --delete_test_files --delete_log_file"
    },
);

1;

