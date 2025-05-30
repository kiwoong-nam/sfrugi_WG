use strict;

my $fI="/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/RP.txt";
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $FO='/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/CNV.txt';

my %CNV;
open my $fd,$cnvF;
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	$CNV{$s[0]}=$s[1];
}
close $fd;

my $res="sample\tgene\tnPos\tCov\tCNV\n";
open my $fd,$fI;
while(<$fd>)
{
	my @s=split("\t",$_);
	$_=~s/\n$/\t$CNV{$s[1]}\n/;
	if($_=~/TE/) {next}
	elsif($_=~/CNV/) {$res.=$_}
	elsif($_=~/total/i)
	{
		$_=~s/\n$/total\n/;
		$res.=$_;
	}
}
close $fd;

open my $fd,">$FO";
print $fd $res;
close $fd;	





















