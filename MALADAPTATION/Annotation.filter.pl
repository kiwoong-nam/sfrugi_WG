use strict;

my $inF='/home/knam/work/sfrugi_WG/MALADAPTATION/Annotation/ver7.gff';
my $outF='/home/knam/work/sfrugi_WG/MALADAPTATION/Annotation/ver7.filtered.gff';

my %stops;
my %bad;

my $good;
open my $fd,$inF;
while(<$fd>)
{
	if($_=~/mRNA/)
	{
		$_=~/ID=(\w+)/;
		my $id=$1;

		$_=~/Identity=(\d\.\d+)/;
		my $identity=$1;
		$_=~/Positive=(\d\.\d+)/;
		my $positive=$1;

		if($_=~/Frame/ or $_=~/Stop/)
		{
			$stops{$id}=1;
			next;
		}
		if($identity <= 0.95 or $positive <= 0.95)
		{
			$bad{$id}=1;
			next;
		}
		$good.=$_;
	}
	else
	{
		$_=~/Parent=(\w+)/;
		my $pID=$1;
		if($stops{$pID} eq '' and $bad{$pID} eq '') {$good.=$_}
	}
}
close $fd;

open my $fd,">$outF";
print $fd $good;
close $fd;



