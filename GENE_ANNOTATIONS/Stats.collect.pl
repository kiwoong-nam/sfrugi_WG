use strict;

my $inD1='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my $inD2='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';
my $outF='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Stats/collect.txt';

my $res="category\tsample\tID\tIdentity\tCoverage\tTarget\n";

opendir my $D,$inD1;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	$f=~/^(.*)\.gff/;
	my $sample=$1;
	if($sample eq '') {next}
	
	my $Fall="$inD1/$f";
	my $Fintact="$inD2/$f";
	
	my %INTACT;
	open my $fd,$Fintact;
	while(<$fd>)
	{
		if($_!~/mRNA/) {next}
		
		my @R=getinfo($_);
		$INTACT{$R[0]}=1;
		$res.="intact\t$sample\t$R[1]";
	}
	close $fd;

	open my $fd,$Fall;
	while(<$fd>)
	{
		if($_!~/mRNA/) {next}
		
		my @R=getinfo($_);
		if($INTACT{$R[0]}==1) {next};
		$res.="stopcodons\t$sample\t$R[1]";
	}
	close $fd;
}

open my $fd,">$outF";
print $fd $res;
close $fd;

sub getinfo
{
	(my $l)=(@_);
	
	$l=~/ID=([\w|\.]+)/;	
	my $id=$1;

	$l=~/Identity=([\w|\.]+)/;	
	my $i=$1;

	$l=~/Positive=([\w|\.]+)/;	
	my $c=$1;

	$l=~/Target=([\w|\.]+)/;	
	my $t=$1;

	return ($id,"$id\t$i\t$c\t$t\n");
}

#			$sres.="$tag\t$sample\t$id\t$i\t$c\t$t\n";


