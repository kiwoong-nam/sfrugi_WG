use strict;

my $inD1='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/listing/list';
my $inD2='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my $fO='/home/kiwoong/Projects/sfrugi_WG/iORF_CNV_Coord/coord.txt';

opendir my $D,$inD2;
my @files=readdir($D);
close $D;

my $res="sample\tRefSeq\tGene.ID\tcontig\tstart\tend\n";

foreach my $f (@files)
{
	$f=~/^(.*)\.gff/;
	my $sample=$1;
	unless($sample =~/F/) {next}
	print "$sample\n";
	
	my $gffF="$inD2/$f";
	my $geneinfoF="$inD1/$sample";
	
	my %INFO;
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

			my @s=split("\t",$_);
			$INFO{$id}="$sample\t$id\t$tid\t$s[0]\t$s[3]\t$s[4]";
		}
	}
	close $fd;

	open my $fd,$geneinfoF;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		unless($s[2] eq 'intact') {next}
		unless($s[3] eq 'CNV') {next}

		if($INFO{$s[0]} ne '') {$res.="$INFO{$s[0]}\n"}
	}
	close $fd;
}

open my $fd,">$fO";
print $fd $res;
close $fd;        


