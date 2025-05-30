use strict;

my $fileIN='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $outF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/frugiperda.pos';

my $res;
open my $fd,$fileIN;
while(<$fd>)
{
	unless($_=~/\tmRNA\t/) {next}
	$_=~/Target=(\w+)/;
	my $id=$1;
	my @s=split("\t",$_);
	$s[0]=~s/HiC_scaffold_//;
	if($s[0] == 29) {$s[0]='Z'}
	if($s[0] > 30) {next}
	
	$res.="$id\t$s[0]\t$s[3]\t$s[4]\n";
}
close $fd;

open my $fd,">$outF";
print $fd $res;
close $fd,


