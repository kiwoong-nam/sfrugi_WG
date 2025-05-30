use strict;

my $listF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $annotF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups_function.list';
my $fO='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/cnvGlisting.txt';

my %F;
open my $fd,$annotF;
while(<$fd>)
{
	$_=~s/\n//g;
	my @s=split("\t",$_);
	$F{$s[0]}=$s[1];
}
close $fd;

my $res;
open my $fd,$listF;
while(<$fd>)
{
	$_=~s/\n//g;
	my @s=split("\t",$_);
	if($s[1] eq 'CNV.GENE')
	{
		$res.="$s[0]\t$F{$s[0]}\n";
	}
}
close $fd;

open my $fd,">$fO";
print $fd $res;
close $fd;
