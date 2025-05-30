use strict;

my $inD1='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/listing/list';
my $inD2='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my $OD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';

opendir my $D,$inD2;
my @files=readdir($D);
close $D;

#miniprotID ncbiID CNV geneL intronN

foreach my $f (@files)
{
	$f=~/^(.*)\.gff/;
	my $sample=$1;
	unless($sample =~/F/) {next}
	print "$sample\n";
	
	my $gffF="$inD2/$f";
	my $geneinfoF="$inD1/$sample";
	my $fO="$OD/$sample";
	
	my %CLeng;
	my %CintronN;
	open my $fd,$gffF;
	while(<$fd>)
	{
		my @s=split("\t",$_);

		if($_=~/\tmRNA\t/)
		{
			$_=~/ID=(\w+)/;
			my $id=$1;

			$_=~/Target=(\w+)/;
			my $tid=$1;
			my $l=$s[4]-$s[3]+1;
			$CLeng{$id}=$l;
		}
		elsif($_=~/\tCDS\t/)
		{
			$_=~/Parent=(\w+)/;
			my $pid=$1;
			$CintronN{$pid}++;
		}
	}
	close $fd;

	my $res;
	open my $fd,$geneinfoF;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		$CintronN{$s[0]}--;
		$res.="$_\t$CLeng{$s[0]}\t$CintronN{$s[0]}\n";
	}
	close $fd;	

	open my $fd,">$fO";
	print $fd $res;
	close $fd;        
}

