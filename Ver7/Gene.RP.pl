use strict;

my $gffF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $RDD='/home/kiwoong/Projects/sfrugi_WG/Ver7/readdepth';
my $FO='/home/kiwoong/Projects/sfrugi_WG/Ver7/Gene/RP.txt';

my @gD;
open my $fd,$gffF;
while(<$fd>)
{
	unless($_=~/mRNA/) {next}
	$_=~/Target=(\w+)/;
	my $id=$1;
	my @s=split("\t",$_);
	push @gD,"$id\t$s[0]\t$s[3]\t$s[4]\n";
}
close $fd;

my %gene;
my $i=0;
foreach my $g (@gD)
{
	my @s=split("\t",$g);

	my $id=shift @s;
	my $chro=shift @s;
	for(my $j=$s[0];$j<$s[1];$j++)
	{
		my $key="$chro\t$j";				
		$gene{$key}=$id;
	}
	$i++;
	print "$i $#gD\n";
}

opendir my $D,$RDD;
my @files=readdir($D);
close $D;

my $res="sample\tgene\tN.position\tSum.cov\n";
foreach my $f (@files)
{
	unless($f=~/(F.*)\.gz/) {next}
	my $sample=$1;
	print "$sample\n";		
	my $totalP;
	my $totalCov;

	my %geneP;
	my %geneCov;

	open my $fd,"zcat $RDD/$f |";
	while(<$fd>)
	{
		if($_=~/#/) {next}
		$_=~s/\n//;
		my @s=split("\t",$_);
		$totalP++;
		$totalCov+=$s[2];

		my $keyP="$s[0]\t$s[1]";	
		my $geneID=$gene{$keyP};

		if($geneID ne '')
		{
			$geneP{$geneID}++;
			$geneCov{$geneID}+=$s[2];
		}
	}
	close $fd;
	
	my @genes=keys %geneP;
	foreach my $g (@genes)
	{
		$res.="$sample\t$g\t$geneP{$g}\t$geneCov{$g}\n";
	}
	$res.="$sample\ttotal\t$totalP\t$totalCov\n";
	saveF();
}

sub saveF
{
	open my $fd,">$FO";
	print $fd $res;
	close $fd;	
}




















