use strict;

my $seqF='/home/kiwoong/Projects/sfrugi_WG/RefSeq/uniq_gene.fa';
my $outF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/CNVptn.fa';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/CNV.txt';

my %SEQ;
my $id;
open my $fd,$seqF;
while(<$fd>)
{
	if($_=~/>(.*)\./) {$id=$1}
	else {$SEQ{$id}.=$_}
}
close $fd;

my $res;
open my $fd,$cnvF;
while(<$fd>)
{
	my @s=split("\t",$_);
	$res.=">$s[0]\n$SEQ{$s[0]}";
}
close $fd;

open my $fd,">$outF";
print $fd $res;
close $fd;
	


