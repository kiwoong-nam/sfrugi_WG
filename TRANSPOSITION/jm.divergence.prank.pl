use strict;

my $jOF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/script/divergence.prank';
my $lD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/divergence/beforealign';
my $iD='/home/knam/work/sfrugi_WG/TRANSPOSITION/divergence/beforealign';
my $oD='/home/knam/work/sfrugi_WG/TRANSPOSITION/divergence/afteralign';

opendir my $D,$lD;
my @files=readdir($D);
close $D;
shift @files;
shift @files;

my $as=0;
for(my $i=1;$i<$#files;$i+=3)
{
	my $st="#!/bin/bash\n";
	
	for(my $j=0;$j<3;$j++)
	{
		my $k=$i+$j;
		my $oID=$files[$k];
		$oID=~s/\.fa//;
		$st.="/home/knam/save/programs/prank/bin/prank -d=$iD/$files[$k] -o=$oD/$oID -codon\n";
	}
	
	open my $fd,">$jOF/j$as";
	print $fd $st;
	close $fd;
	
	print "sbatch j$as\n";
	$as++;
}

	
	


