use strict;

my $gffD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';
my $outF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/counts/geneID';

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
			$_=~/Target=([\w|\.]+)/;
			$GENES{$1}.="$index\t";
		}
	}
	close $fd;
	
}


