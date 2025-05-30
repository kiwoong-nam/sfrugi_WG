use strict;

my $stopsF='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/filter_pseudo/stopcodons.txt';
my $IgffD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/filter_pseudo/gff';
my $OgffD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';

my %STOPS;
open my $fd,$stopsF;
while(<$fd>)
{
	$_=~s/\n//;
	$STOPS{$_}=1;
}
close $fd;

opendir my $D,$IgffD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/^(.*)\.gff/) {next}
	my $sample=$1;
	
	my $fO="$OgffD/$f";

	my $good;
	open my $fd,"$IgffD/$f";
	while(<$fd>)
	{
		if($_=~/mRNA/)
		{
			$_=~/ID=(\w+)/;
			my $id=$1;
 			my $key="$sample\t$id";
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
 			my $key="$sample\t$pID";
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
}
