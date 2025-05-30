use strict;

my $RMD='/home/knam/work/sfrugi_WG/POSITION/TE/repeatmasker';
my $ragtagD='/home/knam/work/sfrugi_WG/POSITION/chromosome/ragtag';
my $indexD='/home/knam/work/sfrugi_WG/POSITION/TE/abundance/index';
my $fo='/home/knam/work/sfrugi_WG/POSITION/TE/abundance/count';

opendir my $D,$indexD;
my @files=readdir($D);
close $D;

my $res="sample\tchrN\tcontig\tRetro\tDNA\tRC\ttotal\tcontigL\n";
foreach my $f (@files)
{
	$f=~/^(.*)\.fa.fai/;
	my $sample=$1;
	
	if($sample eq "") {next}
	print "$sample\n";

	my $indexF="$indexD/$f";
	my $ragtagF="$ragtagD/$sample.ragtag.scaffold.agp";
	my $repeatmaskerF="$RMD/$sample/$sample.fa.out";
	
	my %contig2chr;
	open my $fd,$ragtagF;
	while(<$fd>)
	{
		$_=~s/_RagTag//;
		my @s=split("\t",$_);
		if($s[4] eq "W" and $s[0]=~/HiC/i) {$contig2chr{$s[5]}=$s[0];}
	}
	close $fd;

	my %RETRO;
	my %RC;
	my %DNA;
	my %TOTAL;

	open my $fd,$repeatmaskerF;
	while(<$fd>)
	{
		$_=~s/\n//;
		$_=~s/^ {1,}//;
		$_=~s/ {1,}$//;
		$_=~s/ {1,}/\t/g;
		my @s=split("\t",$_);

		my $l=$s[6]-$s[5]+1;
		if($s[10]=~/LINE/)
		{
			$RETRO{$s[4]}+=$l;
			$TOTAL{$s[4]}+=$l
		}
		elsif($s[10]=~/SINE/) 
		{
			$RETRO{$s[4]}+=$l;
			$TOTAL{$s[4]}+=$l
		}
		elsif($s[10]=~/LTR/) 
		{
			$RETRO{$s[4]}+=$l;
			$TOTAL{$s[4]}+=$l
		}
		elsif($s[10]=~/DNA/) 
		{
			$DNA{$s[4]}+=$l;
			$TOTAL{$s[4]}+=$l
		}
		elsif($s[10]=~/RC/)
		{
			$RC{$s[4]}+=$l;
			$TOTAL{$s[4]}+=$l
		}
		elsif($s[10]=~/Unknown/) {$TOTAL{$s[4]}+=$l}
	}
	close $fd;


	open my $fd,$indexF;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		if($contig2chr{$s[0]} eq "") {next}
		$res.="$sample\t$contig2chr{$s[0]}\t$s[0]\t$RETRO{$s[0]}\t$DNA{$s[0]}\t$RC{$s[0]}\t$TOTAL{$s[0]}\t$s[1]\n";
	}
	close $fd;
	
	$res=~s/\t\t/\t0\t/g;
	$res=~s/\t\t/\t0\t/g;
	$res=~s/\t\n/\t0\n/g;
	$res=~s/HiC_scaffold_//g;	

	open my $fd,">$fo";
	print $fd $res;
	close $fd;

}

