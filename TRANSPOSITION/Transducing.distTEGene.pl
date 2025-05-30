use strict;

my $inD="/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/TE/repeatmasker";
my $DO="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Transducing/distTEGene";
my $gffD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';
my $cnvD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/dupl';

opendir my $D,$inD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	if($f=~/fa/) {next}
	unless($f=~/^(F\w+)/) {next}
	my $sample=$1;
	print "$sample\n";

	my $fIr="$inD/$f/$sample.fa.out";
	my $fgff="$gffD/$sample.gff";
	my $cnvF="$cnvD/$sample.dupl";
	my $fO="$DO/$sample";

	my %CNV;
	open my $fd,$cnvF;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		$CNV{$s[0]}='CNV';
	}
	close $fd;

	my %LINE;
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
			$LINE{$key}.="$single[5]\t$single[6]\n";
		}
	}
	close $fd;

	my %GENE;
	open my $fd,$fgff;
	while(<$fd>)
	{
		if($_=~/\tmRNA\t/)
		{
			my @single=split("\t",$_);
			$_=~/Target=(\w+)/;
			my $id=$1;
			my $key=$single[0];
			my $CNVI=$CNV{$id};
			if($CNVI eq "") {$CNVI="nonCNV"}
			$GENE{$key}.="$CNVI\t$id\t$single[3]\t$single[4]\n";
		}
	}
	close $fd;

	my $res="cnv\tgene\tD\n";
	my @cts=keys %GENE;
	foreach my $c (@cts)
	{
		my @L=sort{$a <=> $b} split("\n",$LINE{$c});
		my @G=split("\n",$GENE{$c});

		foreach my $gl (@G)
		{
			my @geneI=split("\t",$gl);
			my $cnv=shift @geneI;
			my $id=shift @geneI;
			
			my $D1=100000000;
			my $D2=100000000;
			L:foreach my $l (@L)
			{
				my $dist1=abs($l-$geneI[0]);
				my $dist2=abs($l-$geneI[1]);	
				
				if($dist1 < $D1) {$D1=$dist1}
				if($dist2 < $D2) {$D2=$dist2}
				
				if($dist1 ==0){$D1=0}
				if($dist2 ==0){$D2=0}
			}
		
			my $D;
			if($D1>$D2) {$D=$D2}
			else {$D=$D1}
			
			if($D1 ==0 and $D2==0) {next}
				
			my $sr="$cnv\t$id\t$D\n";
			$res.=$sr;
		}
	}
	open my $fd,">$fO";
	print $fd $res;
	close $fd;
}

