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
if (!defined($main::attr{start_sector})) {
    $main::attr{start_sector} = 30000000;
}
if (!defined($main::attr{timestamps})) {
    $main::attr{timestamps} = 0;
}

my $loops_nr = $main::attr{loops_nr};
my $concurr_requests_nr = $main::attr{conc_req_nr};
my $raw_dev_file = $main::attr{raw_dev_file};
my $start_sector = $main::attr{start_sector};
my $timestamps = ($main::attr{timestamps} == 0) ? "" : "--timestamps";

# the list of tests in this suite.
# This array contains a list of anonymous hash references
@main::tests = (
    { name => "AsyncSeq RAW - clean",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=1 --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector - 1000) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=512343 --skip_size=0 --const --seed=0xFFFFFFFF --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    ###################################3
    { name => "AsyncSeq RAW - IO size and skip size more than total space",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=2051 --signature_period=512 --skip_size=5423 --seed=0x87654321 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size and skip size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=2051 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size and skip size more than total space",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=2051 --signature_period=512 --skip_size=5423  --seed=0x87654322 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size and skip size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=2051 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "AsyncSeq RAW - IO size and skip size more than total space - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=2051 --skip_size=5423 --const --seed=0x87654323 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size and skip size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=2051 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size and skip size more than total space - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=2051 --skip_size=5423 --const --seed=0x87654324 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size and skip size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=2051 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    ################################
    
    { name => "AsyncSeq RAW - IO size equals total space",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=3601 --signature_period=512 --skip_size=5423  --seed=0x87654325 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size equals total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=3601 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - IO size equals total space",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=3601 --signature_period=512 --skip_size=5423  --seed=0x87654326 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size equals total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=3601 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "AsyncSeq RAW - IO size equals total space - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=3601 --skip_size=5423 --const --seed=0x87654327 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size equals total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=3601 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size equals total space - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=3601 --skip_size=5423 --const --seed=0x87654328 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size equals total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=3601 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    ################################
    
    { name => "AsyncSeq RAW - IO size more than total space",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=514313 --signature_period=512 --skip_size=5423  --seed=0x87654329 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=514313 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - IO size more than total space",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=514313 --signature_period=512 --skip_size=5423  --seed=0x8765432A --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000) . " --IO_size=514313 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "AsyncSeq RAW - IO size more than total space - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 6) . " --IO_size=514313 --skip_size=5423 --const --seed=0x8765432B --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=". ($start_sector + 1000) . " --IO_size=514313 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size more than total space - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=". ($start_sector + 6) . " --IO_size=514313 --skip_size=5423 --const --seed=0x8765432C --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - IO size more than total space - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 7) . " --end_sector=" . ($start_sector + 1000). " --IO_size=514313 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
   
    ################################
    
    { name => "AsyncSeq RAW - last chunk full IO, no skip",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1644) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCD0 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO, no skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1645) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO, no skip",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1644) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCD1 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO, no skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1645) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "AsyncSeq RAW - last chunk full IO, no skip - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1644) . " --IO_size=6656 --signature_period=512 --skip_size=9728 --const --seed=0xAABBCCD2 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO, no skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1645) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO, no skip - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=". ($start_sector + 1644) . " --IO_size=6656 --signature_period=512 --skip_size=9728 --const --seed=0xAABBCCD3 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO, no skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1645) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    #########################################
    
    { name => "AsyncSeq RAW - last chunk partial IO",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1664) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCD4 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk partial IO - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1665) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial IO ",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1664) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCD5 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial IO - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1665) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "AsyncSeq RAW - last chunk partial IO - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1664) . " --IO_size=6656 --signature_period=512 --skip_size=9728 --const --seed=0xAABBCCD6 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial IO - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1665) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk full IO partial IO - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq  --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1664) . " --IO_size=6656 --signature_period=512 --skip_size=9728 --const --seed=0xAABBCCD7 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial IO - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1665) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    #########################
    { name => "AsyncSeq RAW - last chunk partial skip",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1726) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCD8 --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk partial skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1727) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial skip",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1726) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCD9 --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1727) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    { name => "AsyncSeq RAW - last chunk partial skip - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1726) . " --IO_size=6656 --skip_size=9728 --const --seed=0xAABBCCDA --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk partial skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1727) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial skip - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1726) . " --IO_size=6656 --skip_size=9728 --const --seed=0xAABBCCDB --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk partial skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1727) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    ########################    
    { name => "AsyncSeq RAW - last chunk IO and skip",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1951) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCDC --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk IO and skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1952) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk IO and skip",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1951) . " --IO_size=6656 --signature_period=512 --skip_size=9728  --seed=0xAABBCCDD --read --write --delete_log_file $timestamps"
    },
    
    { name => "SyncSeq RAW - last chunk IO and skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1952) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    { name => "AsyncSeq RAW - last chunk IO and skip - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=AsyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1951) . " --IO_size=6656 --skip_size=9728 --const --seed=0xAABBCCDE --read --write --conc_req_nr=$concurr_requests_nr --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk IO and skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1952) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk IO and skip - const data",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=$start_sector --end_sector=" . ($start_sector + 1951) . " --IO_size=6656 --skip_size=9728 --const --seed=0xAABBCCDF --read --write --delete_log_file $timestamps"
    },

    { name => "SyncSeq RAW - last chunk IO and skip - checking that there is no overflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector + 1952) . " --end_sector=" . ($start_sector + 10000) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
    
    ######## 

    { name => "SyncSeq RAW - checking that there is no underflow",
      script => 'test_seq_raw_basic.pl',
      params => "--test=SyncSeq --loops_nr=$loops_nr --raw_dev_file=$raw_dev_file --start_sector=" . ($start_sector - 1000) . " --end_sector=" . ($start_sector - 1) . " --IO_size=6656 --skip_size=0 --const --seed=0xFFFFFFFF --read --delete_log_file $timestamps"
    },
);

1;
