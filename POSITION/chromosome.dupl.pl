use strict;

my $gffD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my @sample=qw(FC01  FC03  FC_100  FC_102  FC_104  FC_106  FC33  FC37  FC54  FC71  FC76  FC78  FC81  FC_84  FC_88  FC_90  FC_95  FC_98 FC02  FC04  FC_101  FC_103  FC_105  FC32  FC35  FC52  FC55  FC72  FC77  FC79  FC82  FC_85  FC_89  FC_92  FC_97  FC_99);
my $cnvGF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/CNV.txt';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $outD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/dupl';

my %CNV;
open my $fd,$cnvF;
while(<$fd>)
{
	$_=~s/\n//;
        my @s=split("\t",$_);
	if($s[1] eq 'CNV.GENE') {$CNV{$s[0]}=1}
}
close $fd;

for(my $i=0;$i<=$#sample;$i++)
{
	my $gffF="$gffD/$sample[$i].gff";
	my $output="$outD/$sample[$i].dupl";
	
	my %LIST;
	open my $fd,$cnvGF;
	while(<$fd>)
	{
	        my @s=split("\t",$_);
		unless($CNV{$s[0]}==1) {next}		
		my @sl=split(",",$s[1]);
		if($sl[$i] > 1) {$LIST{$s[0]}=1}
	}
	close $fd;

	my %genes;
	open my $fd,$gffF;
	while(<$fd>)
	{
		$_=~/Target=(\w+)/;
		my $id=$1;
		unless($LIST{$id}==1) {next}
		unless($_=~/mRNA/) {next}
		my @single=split("\t",$_);
		$genes{$id}.="$single[0]\t"	
	}
	close $fd;
	
	my @k=keys %genes;
	
	my $parsed;
	foreach my $g (@k)
	{
		$parsed.="$g\t$genes{$g}\n";
	}
	$parsed=~s/\t\n/\n/g;

	open my $fd,">$output";
	print $fd $parsed;
	close $fd;      
}


