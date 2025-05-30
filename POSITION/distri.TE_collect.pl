use strict;

my $inD="/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/TE/repeatmasker";
my $ragD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/ragtag';
my $fO="/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/TE_leng.txt";

opendir my $D,$inD;
my @files=readdir($D);

my $res="sample\tchrN\ttotal.TE\tLINE\n";
foreach my $f (@files)
{
	if($f=~/fa/) {next}
	unless($f=~/^(F\w+)/) {next}
	my $sample=$1;
	print "$sample\n";
	my $fI="$inD/$f/$sample.fa.out";
	my $rF="$ragD/$sample.ragtag.scaffold.agp";

	my %MAPS;
        open my $fd,$rF;
	while(<$fd>)
	{
		my @s=split("\t",$_);
		if($s[4] eq "W" and $_=~/HiC/)
		{
			my $k="$sample\t$s[5]";
			$s[0]=~s/HiC_scaffold_//g;
			$s[0]=~s/_RagTag//g;
 
			$MAPS{$s[5]}=$s[0];
		}
	}
	close $fd;

	my %ALL;
	my %LINE;
	
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/^ {1,}//;
		$_=~s/ {1,}^//;
		$_=~s/ {1,}/\t/g;
		my @single=split("\t",$_);
		my $l=$single[6]-$single[5];
		if($single[10] eq 'Simple_repeat') {next}
		if($single[10] eq 'Low_complexity') {next}
		if($single[10] eq 'Satellites') {next}
		if($single[10] =~/tRNA/) {next}
		if($single[10] =~/rRNA/) {next}

		my $chrN=$MAPS{$single[4]};
		$ALL{$chrN}+=$l;
		if($single[10]=~/LINE/) {$LINE{$chrN}+=$l;}
	}

	for(my $i=1;$i<30;$i++)
	{
		$res.="$sample\t$i\t$ALL{$i}\t$LINE{$i}\n";
	}
}

open my $fd,">$fO";
print $fd $res;
close $fd;
