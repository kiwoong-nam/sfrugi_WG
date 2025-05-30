use strict;

my $s1='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input/seq/exigua.fa';
my $s2='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input/seq/litura.fa';
my $s3='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input/seq/frugiperda.fa';

my $o1='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/fx/exigua.fa';
my $o2='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/fx/litura.fa';
my $o3='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/fx/frugiperda.fa';

my $exigua;
open my $fd,$s1;
while(<$fd>)
{
	if($_=~/>/){$_=~s/ .*$// }
	else {$_=~s/\./X/g}
	$exigua.=$_;
}
close $fd;

my $litura;
open my $fd,$s2;
while(<$fd>)
{
	if($_=~/>/){$_=~s/ .*$// }
	else {$_=~s/\./X/g}
	$litura.=$_;
}
close $fd;

my $frugiperda;
open my $fd,$s3;
while(<$fd>)
{
	if($_=~/>/)
	{
		$_=~s/\-.*$//;
		$_=~s/\..*$//;
	}
	else {$_=~s/\./X/g}
	$frugiperda.=$_;
}
close $fd;

open my $fd,">$o1";
print $fd $exigua;
close $fd;


open my $fd,">$o2";
print $fd $litura;
close $fd;

open my $fd,">$o3";
print $fd $frugiperda;
close $fd;

