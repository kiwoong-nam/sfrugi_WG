use strict;

my $gffD1='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/miniprot/refseq/raw';
my $gffD2='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';
my $gffD3='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';

my $outF='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/counts/refseq.txt';

my $tg=14678;

my $res="sample\trefseq\tall\tmapped.gene\tintact.gene\tprop.mapping\tprop.final\n";

opendir my $D,$gffD1;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	if($f=~/^(.*)\.gff/)
	{
		my $sample=$1;
		my $gall=calcO("$gffD1/$f");
		my $gf1=calcO("$gffD3/$f");
		my $gintact=calcO("$gffD2/$f");

		my $p1=$gall/$tg;
		my $p2=$gintact/$tg;
		
		$res.="$sample\t$tg\t$gall\t$gf1\t$gintact\t$p1\t$p2\n";
		
		print "$sample\t$tg\t$gall\t$gf1\t$gintact\n";
	}
}

open my $fd,">$outF";
print $fd $res;
close $fd;



sub calcO
{
	(my $fileIn)=(@_);
	
	my %Genes;
	open my $fd,$fileIn;
	while(<$fd>)
	{
		$_=~/Target=([\w|\.]+)/;
		$Genes{$1}=1;
	}
	close $fd;
	
	my @gs=keys %Genes;
	return ($#gs+1);
}


