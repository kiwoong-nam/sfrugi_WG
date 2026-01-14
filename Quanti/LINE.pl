use strict;

my $rmD="/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/TE/repeatmasker";
my $gffD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $cnvGF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/CNV.txt';

my $DI_trans='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro';
my $outD='/home/kiwoong/Projects/sfrugi_WG/Quanti/LINE';

my @sample=qw(FC01  FC03  FC_100  FC_102  FC_104  FC_106  FC33  FC37  FC54  FC71  FC76  FC78  FC81  FC_84  FC_88  FC_90  FC_95  FC_98 FC02  FC04  FC_101  FC_103  FC_105  FC32  FC35  FC52  FC55  FC72  FC77  FC79  FC82  FC_85  FC_89  FC_92  FC_97  FC_99);

my %CNV;
open my $fd,$cnvF;
while(<$fd>)
{
	$_=~s/\n//;
        my @s=split("\t",$_);
	if($s[1] eq 'CNV.GENE') {$CNV{$s[0]}=1}
}
close $fd;

for(my $i=0;$i<=$#sample;$i++)
{
	my $FI_trans="$DI_trans/$sample[$i]";
	my $fIr="$rmD/$sample[$i]/$sample[$i].fa.out";
	my $gffF="$gffD/$sample[$i].gff";

	my $output="$outD/$sample[$i]";

	my %LIST;
	open my $fd,$cnvGF;
	while(<$fd>)
	{
	        my @s=split("\t",$_);
		unless($CNV{$s[0]}==1) {next}		
		my @sl=split(",",$s[1]);
		if($sl[$i] > 1) {$LIST{$s[0]}=1}
	}
	close $fd;

	my %CTG;
	open my $fd,$gffF;
	while(<$fd>)
	{
		$_=~/Target=(\w+)/;
		my $id=$1;
		unless($LIST{$id}==1) {next}
		unless($_=~/mRNA/) {next}

		$_=~/ID=(\w+)/;
		my $gID=$1;
		my @single=split("\t",$_);
		my $key=$single[0];

		if($LIST{$id} ==1) {$CTG{$key}.="$gID\t$single[3]\t$single[4]\n";}
	}
	close $fd;

	my %RM;
	open my $fd,$fIr;
	while(<$fd>)
	{
		$_=~s/^ {1,}//;
		$_=~s/ {1,}^//;
		$_=~s/ {1,}/\t/g;
		my @single=split("\t",$_);
		if($single[10]=~/LINE/)
		{
			my $key=$single[4];
			$RM{$key}.="$single[5]\t$single[6]\n";
		}
	}
	close $fd;

	my %genes;
	my %LINE;

	my @cts=keys %CTG;
	foreach my $c (@cts)
	{
		my @L=sort{$a <=> $b} split("\n",$RM{$c});
		my @G=split("\n",$CTG{$c});
		foreach my $gl (@G)
		{
			my @geneI=split("\t",$gl);
			my $id=shift @geneI;
			my $D1=100000000;
			my $D2=100000000;
			my $D3=100000000;
			my $D4=100000000;
			L:foreach my $l (@L)
			{
				my @Ls=split("\t",$l);

				my $dist1=abs($Ls[0]-$geneI[0]);
				my $dist2=abs($Ls[0]-$geneI[1]);	
				my $dist3=abs($Ls[1]-$geneI[0]);
				my $dist4=abs($Ls[1]-$geneI[1]);	
				
				if($dist1 < $D1) {$D1=$dist1}
				if($dist2 < $D2) {$D2=$dist2}
				if($dist3 < $D3) {$D3=$dist1}
				if($dist4 < $D4) {$D4=$dist2}
				
				if($dist1 ==0){$D1=0}
				if($dist2 ==0){$D2=0}
				if($dist3 ==0){$D3=0}
				if($dist4 ==0){$D4=0}
			}
		
			my @dists=sort {$a<=> $b} ($D1,$D2,$D3,$D4);

			if($dists[0]>0)
			{
				$genes{$id}=1;	
				if($dists[0]<100) {$LINE{$id}=1}
			}
		}
	}
		
	open my $fd,$FI_trans;
	while(<$fd>)
	{
		my @s=split("\t",$_);
		unless($s[2] eq 'CNV') {next}
		unless($s[3] eq 'intact') {next}

		$genes{$s[1]}=1;	
		if($_!~/NA/) {$LINE{$s[1]}=1}
	}
	close $fd;

	my @gs=keys %genes;
	my $res;
	my $n0;
	my $n1;
	foreach my $g (@gs)
	{
		my $line='none';
		$n0++;
		if($LINE{$g}==1)
		{
			$line = 'line';
			$n1++;
		}
		$res.="$g\t$line\n";
	}
	
	print "$sample[$i] $n0 $n1\n";
	
	open my $fd,">$output";
	print $fd $res;
	close $fd;





}




