use strict;

my $WD='/home/knam/work/sfrugi_WG/MALADAPTATION/Annotation';
my $stopsF="$WD/stopcodons.txt";
my $fI="$WD/ver7.filtered.gff";
my $fO="$WD/ver7.final.gff";

my %STOPS;
open my $fd,$stopsF;
while(<$fd>)
{
	$_=~s/\n//;
	$STOPS{$_}=1;
}
close $fd;

my $good;
open my $fd,$fI;
while(<$fd>)
{
	if($_=~/mRNA/)
	{
		$_=~/ID=(\w+)/;
		my $id=$1;
 		my $key="$id";
 		if($STOPS{$key}==1)
		{
			print $_;
			next
		}		
		else{$good.=$_}
	}
	else
	{
		$_=~/Parent=(\w+)/;
		my $pID=$1;
 		my $key="$pID";
 		if($STOPS{$key}==1)
		{
			print $_;
			next
		}		
		else{$good.=$_}
	}
}
close $fd;
	
open my $fd,">$fO";
print $fd $good;
close $fd;

