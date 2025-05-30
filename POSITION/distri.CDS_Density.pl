use strict;

my $fI='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $fO='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CDS_Density.txt';

my $WS=100000;

my %CDS;
open my $fd,$fI;
while(<$fd>)
{
	unless($_=~/CDS/) {next}
	$_=~/HiC_scaffold_(\d+)/;
	my $chrN=$1;
	if($chrN>29) {next}
	
	my @s=split("\t",$_);
	my $l=$s[4]-$s[3];
	my $w="$chrN\t".(int $s[3]/$WS);
	$CDS{$w}+=$l;
}
close $fd;

my @pos=sort {$a <=> $b} keys %CDS;

my $res="chro\tstart\tCDS\n";

foreach my $p (@pos)
{
	$res.="$p\t$CDS{$p}\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;

