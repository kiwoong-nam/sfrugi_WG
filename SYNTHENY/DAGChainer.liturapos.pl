use strict;

my $fileIN='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCF_002706865.2_ASM270686v3_genomic.gff.gz';
my $outF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/litura.pos';

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

#print $CDS{'XP_022817064.1'};exit;

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
	
	$H{"NC_036187.1"}=1;
	$H{"NC_036188.1"}=2;
	$H{"NC_036189.1"}=3;
	$H{"NC_036190.1"}=4;
	$H{"NC_036191.1"}=5;
	$H{"NC_036192.1"}=6;
	$H{"NC_036193.1"}=7;
	$H{"NC_036194.1"}=8;
	$H{"NC_036195.1"}=9;
	$H{"NC_036196.1"}=10;
	$H{"NC_036197.1"}=11;
	$H{"NC_036198.1"}=12;
	$H{"NC_036199.1"}=13;
	$H{"NC_036200.1"}=14;
	$H{"NC_036201.1"}=15;
	$H{"NC_036202.1"}=16;
	$H{"NC_036203.1"}=17;
	$H{"NC_036204.1"}=18;
	$H{"NC_036205.1"}=19;
	$H{"NC_036206.1"}=20;
	$H{"NC_036207.1"}=21;
	$H{"NC_036208.1"}=22;
	$H{"NC_036209.1"}=23;
	$H{"NC_036210.1"}=24;
	$H{"NC_036211.1"}=25;
	$H{"NC_036212.1"}=26;
	$H{"NC_036213.1"}=27;
	$H{"NC_036214.1"}=28;
	$H{"NC_036215.1"}=29;
	$H{"NC_036216.1"}=30;
	$H{"NC_036217.1"}='Z';
	return %H;
}
