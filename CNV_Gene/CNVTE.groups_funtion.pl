use strict;

my $annotF='/home/kiwoong/Projects/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_protein.faa.gz';
my $iF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups';
my $oF1='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups_function';
my $oF2='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups_function.list';

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
my $resG;
open my $fd,"$iF";
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);

	my $gid=shift @s;
	my $te=shift @s;
	
	my $func;
	if($te eq 'no')
	{
		foreach my $g (@s)
		{
			if($g=~/X/) {$resG.="$g\t$FCn{$g}\n";}
			$func.="$FCn{$g}|";
		}
        }
	else {$func='te'}
	
	$res.="$gid\t$func\t".join("\t",@s)."\n";
}

open my $fd,">$oF1";
print $fd $res;
close $fd;

open my $fd,">$oF2";
print $fd $resG;
close $fd;





