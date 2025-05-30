use strict;

my $iD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR/beforealign';
my $oD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR/afteralign';
my $OF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/script/5UTR.prank.sh';

opendir my $D,$iD;
my @files=readdir($D);
close $D;
shift @files;
shift @files;

my $st="#!/bin/bash\n";

$st.="#prank v.170427.\n\n";

for(my $i=1;$i<$#files;$i++)
{
	my $k=$i;
	my $oID=$files[$k];
	$oID=~s/\.fa//;
	$st.="prank -d=$iD/$files[$k] -o=$oD/$oID -DNA\n";
}
	
open my $fd,">$OF";
print $fd $st;
close $fd;

	
	


