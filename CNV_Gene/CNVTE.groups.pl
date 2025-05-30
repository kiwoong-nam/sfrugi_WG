use strict;

my $pF='/home/kiwoong/Projects/sfrugi_WG/POSITION/CNVTE/proportion.txt';
my $cnvGF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/Grouppings.txt';
my $oF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups';

my %RP;
open my $fd,$pF;
while(<$fd>)
{
	if($_=~/ID/) {next}

	$_=~s/\n//;
	my @s=split("\t",$_);
	if($s[1]>0.9) {$RP{$s[0]}="TE"}
}
close $fd;

my $res;
my $g=1;
open my $fd,$cnvGF;
L:while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);

	my $gid="g$g";
	my $gn=shift @s;

	my $te='no';

	foreach my $g (@s)
	{
		if($RP{$g} eq 'TE') {next L}
	}

	$res.="$gid\t$te\t".join("\t",@s)."\n";
	$g++;
}

open my $fd,">$oF";
print $fd $res;
close $fd;
