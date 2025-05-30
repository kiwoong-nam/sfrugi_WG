use strict;

my $fileIN='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCA_902829305.4_PGI_SPEXI_v6_genomic.gff.gz';
my $outF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/exigua.pos';

my %chrN=getG();

my %CDS;
my %chros;
open my $fd,"zcat $fileIN | ";
while(<$fd>)
{
	unless($_=~/\tCDS\t/) {next}
	$_=~/Name=(\w+\.\d)/;
	my $geneN=$1;
	my @s=split("\t",$_);

	my $chro=$chrN{$s[0]};

	if($chro eq '') {next};
	$CDS{$geneN}.="$s[3]\n";	
	$CDS{$geneN}.="$s[4]\n";	
	$chros{$geneN}=$chro;

}
close $fd;

my @geneN=keys %CDS;
my $res;
foreach my $p (@geneN)
{
	my $ch=$chros{$p};
	if($ch eq "") {next}

	my @pos=split("\n",$CDS{$p});
	@pos=sort {$a <=> $b} @pos;
	my $start=shift @pos;
	my $end=pop @pos;

	$res.="$p\t$chros{$p}\t$start\t$end\n";
}

open my $fd,">$outF";
print $fd $res;
close $fd;


sub getG
{
	my %H;
	$H{"LR824602.2"}=1;
	$H{"LR824603.2"}=2;
	$H{"LR824604.2"}=3;
	$H{"LR824605.2"}=4;
	$H{"LR824606.2"}=5;
	$H{"LR824607.2"}=6;
	$H{"LR824608.2"}=7;
	$H{"LR824609.2"}=8;
	$H{"LR824610.2"}=9;
	$H{"LR824611.2"}=10;
	$H{"LR824612.2"}=11;
	$H{"LR824613.2"}=12;
	$H{"LR824614.2"}=13;
	$H{"LR824615.2"}=14;
	$H{"LR824616.2"}=15;
	$H{"LR824617.2"}=16;
	$H{"LR824618.2"}=17;
	$H{"LR824619.2"}=18;
	$H{"LR824620.2"}=19;
	$H{"LR824621.2"}=20;
	$H{"LR824622.2"}=21;
	$H{"LR824623.2"}=22;
	$H{"LR824624.2"}=23;
	$H{"LR824625.2"}=24;
	$H{"LR824626.2"}=25;
	$H{"LR824627.2"}=26;
	$H{"LR824628.2"}=27;
	$H{"LR824629.2"}=28;
	$H{"LR824630.2"}=29;
	$H{"LR824631.2"}=30;
	$H{"LR824601.2"}='Z';
	return %H;
}
