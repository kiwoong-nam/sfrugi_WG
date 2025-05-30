use strict;

my $CNVlistF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $gffF='/home/kiwoong/Projects/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_genomic.gff.gz';
my $fO='/home/kiwoong/Projects/sfrugi_WG/ABUNDANCE/Propensity/CNV_Gene.txt';

my $WS=100000;

my %CNVG;
open my $fd,$CNVlistF;
while(<$fd>)
{
	if($_=~/\tCNV.GENE/)
	{
		my @s=split("\t",$_);
		$CNVG{$s[0]}=1;
	}
}
close $fd;

my %CNVSs;
open my $fd,"zcat $gffF | ";
while(<$fd>)
{
	$_=~s/\n//g;
	unless($_=~/\tCDS\t/) {next}
	$_=~/Parent=([\w|\-|\.]+)/;
	my $mrna=$1;
	my $as=$_;
	$as=~s/protein_id=(.*)$//;
	my $id=$1;
	$id=~s/;.*$//;
	$id=~s/\..*$//;
        unless($CNVG{$id} == 1) {next}
	$CNVSs{$mrna}=1;
}

my %Sum;
my %NC;
open my $fd,"zcat $gffF | ";
while(<$fd>)
{

	unless($_=~/\tmRNA\t/) {next}
	$_=~/ID=([\w|\-|\.]+)/;
	my $id=$1;
	if($CNVSs{$id} eq '') {next}

	my @s=split("\t",$_);
	my $l=$s[4]-$s[3]+1;	
	my $K="$s[0]\t".(int($s[3]/$WS)*$WS+1);

	$NC{$K}++;
	$Sum{$K}+=$l;
}
close $fd;

my @ws=sort {$a cmp $b} keys %NC;

my $res="chr\tstart\tCNV.n\tCNV.l\n";
foreach my $w (@ws)
{
	$res.="$w\t$NC{$w}\t$Sum{$w}\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;

