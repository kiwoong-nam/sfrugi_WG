use strict;

my $ogsF='/usr/local/bioinfo/src/BUSCO/datasets_odb10/arthropoda_odb10/ancestral';
my $gffD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/busco';
my $outF='/home/knam/work/sfrugi_WG/CNV_Gene/busco/buscoID';

my %GENES;

my $res="sample\tidentified\ttotal\tprop\n";
opendir my $D,$gffD;
while(readdir($D))
{
	if($_=~/^(.*)\.gff/)
	{
		my $sample=$1;
		calcO("$gffD/$_",$sample);
	}

}
close $D;

my $res;
my @genes=keys %GENES;
foreach my $g (@genes)
{
	$res.="$g\t$GENES{$g}\n"

}

$res=~s/\t\n/\n/g;

open my $fd,">$outF";
print $fd $res;
close $fd;


sub calcO
{
	(my $fileIn,my $index)=(@_);
	
	open my $fd,$fileIn;
	while(<$fd>)
	{
		if($_=~/>/ or $_=~/mRNA/)
		{
			$_=~/\d+at\d+/;
			$GENES{$&}.="$index\t";
		}
	}
	close $fd;
	
}


