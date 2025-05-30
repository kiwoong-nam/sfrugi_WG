use strict;

my $fI_faw='/home/knam/work/sfrugi_WG/TRANSPOSITION/calc/leng_intronN.txt';
my $fI_exigua='/home/knam/work/sfrugi_WG/TRANSPOSITION/IntronN/exigua.txt';
my $fI_litura='/home/knam/work/sfrugi_WG/TRANSPOSITION/IntronN/litura.txt';
my $noncnvF='/home/knam/work/sfrugi_WG/CNV_Gene/CNV/noCNV.txt';
my $SOD='/home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/res/Results_Nov26/Single_Copy_Orthologue_Sequences';
my $fO="/home/knam/work/sfrugi_WG/SYNTHENY/Gene/singleortholog/intronN";

my %noncnv;
open my $fd,$noncnvF;
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	$noncnv{$s[0]}=1;
}
close $fd;
my %FAW=getI($fI_faw,2);
my %Exigua=getI($fI_exigua,1);
my %Litura=getI($fI_litura,1);

opendir my $D,$SOD;
my @files=readdir($D);
close $D;

my $res="gene\tfaw\tlitura\texigua\n";
foreach my $f (@files)
{
	unless($f=~/fa/) {next}
	
	open my $fd,"$SOD/$f";
	my @data=<$fd>;
	close $fd;

	$data[0]=~s/>//; # exigua
	$data[2]=~s/>//; # frugiperda
	$data[4]=~s/>//; # litura
	$data[0]=~s/\n//;
	$data[2]=~s/\n//;
	$data[4]=~s/\n//;
	$data[2]=~s/\..*$//;

	unless($noncnv{$data[2]}==1) {next}

	if($FAW{$data[2]} eq '') {next}
	if($Exigua{$data[0]} eq '') {next}
	if($Litura{$data[4]} eq '') {next}
	
	print "$data[2]\t$FAW{$data[2]}\t$Litura{$data[4]}\t$Exigua{$data[0]}\n";
	$res.="$data[2]\t$FAW{$data[2]}\t$Litura{$data[4]}\t$Exigua{$data[0]}\n";
	if($FAW{$data[4]} == 14) {print "$data[4]\t$FAW{$data[4]}\t$Litura{$data[2]}\t$Exigua{$data[0]}\n";}
}

open my $fd,">$fO";
print $fd $res;
close $fd;

sub getI
{
	(my $fI,my $cN)=(@_);
	
	my %p;
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		$p{$s[0]}=$s[$cN];		
	}
	close $fd;
	
	return %p;
}

