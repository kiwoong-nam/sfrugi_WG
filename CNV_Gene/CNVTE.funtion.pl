use strict;

my $annotF='/home/kiwoong/Projects/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_protein.faa.gz';
my $listF="/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt";
my $oF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/function.list';

my %FCn;
open my $fd,"zcat $annotF | ";
while(<$fd>)
{
	if($_=~/>/)
	{
		$_=~s/>(\w+)\.\d //;
		my $id=$1;
		$_=~s/\n//;
		$_=~s/\[.*//;
		$FCn{$id}=$_;
	}
}
close $fd;

my $res;
open my $fd,"$listF";
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	if($s[1] eq 'CNV.GENE')
	{
		$res.="$s[0]\t$FCn{$s[0]}\n";
	}
	
}
close $fd;

open my $fd,">$oF";
print $fd $res;
close $fd;





