use strict;

my $DI='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/chromosome';
my $gffF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $fO='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CNV_prop.txt';

opendir my $D,$DI;
my @files=readdir($D);
close $D;

my $res;
foreach my $f (@files)
{
	unless($f=~/F/) {next}

	my %CNVGENES;
	my @CNV;
	open my $fd,"$DI/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		$CNVGENES{$s[0]}=$s[1];

		my @P=split(",",$s[1]);
		foreach my $chr (@P) {$CNV[$chr]++}

	}
	close $fd;
	
	my @ALL;
	open my $fd,$gffF;
	while(<$fd>)
	{
		unless($_=~/mRNA/) {next}
		$_=~s/HiC_scaffold_//;
		my @s=split("\t",$_);

		$_=~/Target=(\w+)/;
		my $id=$1;
		if($CNVGENES{$id} eq '') {$ALL[$s[0]]++}
	}
	close $fd;

	for(my $i=1;$i<30;$i++)
	{
		my $p=$CNV[$i]/$ALL[$i];
		$res.="$f\t$i\t$p\n";
	}
}

$res=~s/\.chrs\.dupl//g;

open my $fd,">$fO";
print $fd $res;
close $fd;

