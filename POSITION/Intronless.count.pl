use strict;

my $fI='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $fO="/home/kiwoong/Projects/sfrugi_WG/POSITION/Intronless/count.txt";

my %gI;
my %gC;
open my $fd,$fI;
while(<$fd>)
{
	if($_=~/\tCDS\t/)
	{
		$_=~/Parent=(\w+)/;
		my $id=$1;
		$_=~/HiC_scaffold_(\d+)/;
		my $chrN=$1;
		$gI{$id}++;
		$gC{$id}=$chrN;
	}
}

my $res="gene\tchrN\texonN\n";
my @genes=keys %gI;
foreach my $g (@genes)
{
	#if($gC{$g}>29) {next}
	$res.="$g\t$gC{$g}\t$gI{$g}\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;
	

