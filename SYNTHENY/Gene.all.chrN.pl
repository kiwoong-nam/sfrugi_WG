use strict;

my $cnvlistF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $fI_faw='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/input/faw';
my $fI_exigua='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/input/exigua';
my $fI_litura='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/input/litura';
my $noncnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/noCNV.txt';
my $orthoF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/res/Results_Nov26/Orthogroups/Orthogroups.txt';
my $outF="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/chrN";

#############################
my %faw=getI($fI_faw);
my %exigua=getI($fI_exigua);
my %litura=getI($fI_litura);

my %cnv;
open my $fd,$cnvlistF;
while(<$fd>)
{
	$_=~s/\n//;
        my @s=split("\t",$_);
	if($s[1] eq 'nonCNV.GENE') {$cnv{$s[0]}='no'}
	elsif($s[1] eq 'CNV.GENE') {$cnv{$s[0]}='yes'}	
}
close $fd;

my $res;
open my $fd,$orthoF;
while(<$fd>)
{
	$_=~s/\n//;
	$_=~s/^(.*): //;
	my $g=$1;
	
	my @s=split(" ",$_);
	my $FAW;
	my $LITURA;
	my $EXIGUA;
	my $CNV;
		
	foreach my $l (@s)
	{
		$l=~s/\..*$//;

		if($l=~/XP_02/)
		{
			if($litura{$l} ne '') {$LITURA.="$litura{$l},"}
		}
		elsif($l=~/YP_008/)
		{
			if($litura{$l} ne '') {$LITURA.="$litura{$l},"}
		}
		elsif($l=~/CA/)
		{
			if($exigua{$l} ne '') {$EXIGUA.="$exigua{$l},"}
		}
		elsif($l=~/XP_05/)
		{
			$l=~s/\..*$//;
			if($faw{$l} ne '')
			{
				$FAW.="$faw{$l},";
				$CNV.="$cnv{$l},";
			}
		}
		elsif($l=~/XP_03/)
		{
			$l=~s/\..*$//;
			if($faw{$l} ne '')
			{
				$FAW.="$faw{$l},";
				$CNV.="$cnv{$l},";
			}
		}
		elsif($l=~/YP_009/)
		{
			$l=~s/\..*$//;
			if($faw{$l} ne '')
			{
				$FAW.="$faw{$l},";
				$CNV.="$cnv{$l},";
			}
		}
		else{print "something is wrong"}
	}


	if($CNV eq "") {next}
	my $sl="$g\t$CNV\t$FAW\t$LITURA\t$EXIGUA\n";
	if($FAW eq '' or $LITURA eq '' or $EXIGUA eq '') {next}
	$res.=$sl;
}

open my $fd,">$outF";
print $fd $res;
close $fd;

	
########################
sub getI
{
	(my $fI)=(@_);
        
	my %p;
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		$s[0]=~s/\..*$//;
		$p{$s[0]}=$s[1]; 
		print "$fI $p{$s[0]}\n";             
	}
	close $fd;
	return %p;
}


