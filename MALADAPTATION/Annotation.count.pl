use strict;

my $WD='/home/knam/work/sfrugi_WG/MALADAPTATION/Annotation';
my $outF="$WD/count.txt";

my $tg=14678;

my $res="sample\trefseq\tall\tF1\tintact\n";

my $gall=calcO("$WD/ver7.gff");
my $gf1=calcO("$WD/ver7.filtered.gff");
my $gintact=calcO("$WD/ver7.final.gff");

$res="sfC\t$tg\t$gall\t$gf1\t$gintact\n";

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


