use strict;

my $ogsF='/usr/local/bioinfo/src/BUSCO/datasets_odb10/lepidoptera_odb10/ancestral';
my $gffD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/busco/raw';
my $outF='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/counts/busco.txt';

my $tg=calcO($ogsF);

my $res="sample\tidentified\ttotal\tprop\n";
opendir my $D,$gffD;
while(readdir($D))
{
	if($_=~/^(.*)\.gff/)
	{
		my $sample=$1;
		my $gns=calcO("$gffD/$_");
		my $prop=(int($gns*10000/$tg)/10000);
		$res.="$sample\t$gns\t$tg\t$prop\n";
		print "$sample\t$gns\t$tg\t$prop\n";
	}

}
close $D;

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
		$_=~/\d+at\d+/;
		$Genes{$&}=1;
	}
	close $fd;
	
	my @gs=keys %Genes;
	return ($#gs+1);
}


