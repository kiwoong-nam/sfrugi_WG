use strict;

my $infoD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';
my $GD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/seq/assembly';
my $gffD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my $OD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/seqs';

my $seqL3=1000;

opendir my $D,$GD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/\w/) {next}

	$f=~/^(\w+).fa.gz/;
	my $sample=$1;
	print "$sample\n";
	if($sample eq '') {next}

	my $assemblyF="$GD/$f";
	my $infoF="$infoD/$sample";
	my $gffF="$gffD/$sample.gff";
	my $fO="$OD/$sample";

	my %SEQ;
	my $id;
	open my $fd,"zcat $GD/$f | ";
	while(<$fd>)
	{
		$_=~s/\n//;
		if($_=~/>(\w+)/){$id=$1}
		else {$SEQ{$id}.=$_}
	}
	close $fd;

	my %INC;
	open my $fd,$infoF;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		if($s[3] eq 'CNV.single') {$s[3]='CNV'}
		$INC{$s[0]}="$s[3]\t$s[2]\t$s[5]";
	}
	close $fd;

	my $res;
	open my $fd,$gffF;
	while(<$fd>)
	{
		unless($_=~/\tmRNA\t/) {next}
		$_=~/ID=(\w+)/;
		my $id=$1;
		$_=~/Target=(\w+)/;
		my $tID=$1;
			
		if($INC{$id} =~/stopcodon/) {next}
		if($INC{$id} eq '' ) {next}

		my @s=split("\t",$_);
			
		my $seq1=substr($SEQ{$s[0]},$s[3]-$seqL3-1,$seqL3);
		my $seq2=substr($SEQ{$s[0]},$s[4],$seqL3);

		my $sres="$tID\t$id\t$INC{$id}\t";

		my $seqP;
		if($s[6] eq "+") {$seqP="$seq1\t$seq2\n"}
		elsif($s[6] eq "-")
		{
			$seq1=reverse $seq1;
			$seq1=~tr/ATGC/TACG/;
			$seq2=reverse $seq2;
			$seq2=~tr/ATGC/TACG/;
			$seqP="$seq2\t$seq1\n";
		}
		$sres.=$seqP;
		$res.=$sres;
	}
	close $fd;

	open my $fd,">$fO";
	print $fd $res;
	close $fd;
}

