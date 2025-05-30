use strict;

my $TEannot='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/TE/repeatmasker/ncbi_RepeatModeler/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_genomic.fna.out';
my $gffF='/home/kiwoong/Projects/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_genomic.gff.gz';
my $CNVF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/list.txt';
my $output='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/proportion.txt';

my %CNV;
open my $fd,$CNVF;
while(<$fd>)
{
	my @s=split("\t",$_);
	$CNV{$s[0]}=1;
}
close $fd;

my %TE;
open my $fd,$TEannot;
while(<$fd>)
{
	$_=~s/\n//;
	$_=~s/^ {1,}//;
	$_=~s/ {1,}$//;
	$_=~s/ {1,}/\t/g;
	my @s=split("\t",$_);

	$TE{$s[4]}.="$s[5]\t$s[6]\t$s[10]\n";
}
close $fd;

my %rna2ptn;

open my $fd,"zcat $gffF | ";
while(<$fd>)
{
	$_=~s/\n//g;
	unless($_=~/\tCDS\t/) {next}
	$_=~/Parent=([\w|\-|\.]+)/;
	my $mrna=$1;
	my $as=$_;
	$as=~s/protein_id=(.*)$//;
	my $id=$1;

	$id=~s/;.*$//;
	$id=~s/\..*$//;
 
	$rna2ptn{$mrna}=$id;
}
close $fd;

my %Genes;
open my $fd,"zcat $gffF | ";
while(<$fd>)
{
	unless($_=~/\tmRNA\t/) {next}
	$_=~/ID=([\w|\-|\.]+)/;
	my $id=$1;
	my $pid=$rna2ptn{$id};
        
	if($CNV{$pid} eq "") {next}

	my @s=split("\t",$_);
	my $key=$s[0];
	$Genes{$key}.=$_;
}
close $fd;
my $res="ID\tprop\trepeat\n";

my @chrs=keys %TE;
foreach my $i (@chrs)
{
	my @T=split("\n",$TE{$i});
	my @G=split("\n",$Genes{$i});

	my %TS;
	L:foreach my $ts (@T)
	{
		my @tsp=split("\t",$ts);
		for(my $j=$tsp[0];$j<=$tsp[1];$j++) {$TS{$j}=$tsp[2]}
	}
	
	M:foreach my $gs (@G)
	{
		$gs=~/ID=([\w|\-|\.]+)/;
		my $gid=$1;
		my $id=$rna2ptn{$gid};
		my @gsp=split("\t",$gs);
		my $r=0;
		my $u=0;
		my $dt='NA';
		for(my $j=$gsp[3];$j<=$gsp[4];$j++)
		{
			if($TS{$j} ne '')
			{
				$r++;
				$dt=$TS{$j};
			}
			else {$u++}
		}
		my $prop=$r/($r+$u);
		
		my $sres="$id\t$prop\t$dt\n";
		print "$sres";
		$res.=$sres;	
	}
	
	open my $fd,">$output";
	print $fd $res;
	close $fd;
}
