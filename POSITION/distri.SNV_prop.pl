use strict;

my $fI='/home/knam/work/sfrugi_WG/SNV/vcf/FC.filtered.SNV.phased.vcf.gz';
my $fO='/home/knam/work/sfrugi_WG/POSITION/distri/SNV_prop.txt';

my $prechr=0;
my @vars;
my $res;
open my $fd,"zcat $fI | ";
L:while(<$fd>)
{
	if($_=~/#/) {next}
	$_=~s/\n//g;	
	$_=~/HiC_scaffold_(\d+)/;
	my $chrN=$1;

	my @s=split("\t",$_);
	if($chrN !=$prechr)
	{
		my $sres;
		if($prechr !=0)
		{
			for(my $ch=9;$ch<=$#s;$ch++)
			{
				my $ind="i".($ch-8);
				$sres.="$ind\t$prechr\t$vars[$ch]\n";
			}
			$res.=$sres;
			saveF();
		}

		$prechr=$chrN,
		undef @vars;
	}

	for(my $i=9;$i<=$#s;$i++)
	{
		$s[$i]=~s/\:.*$//;
		$s[$i]=~s/[\||\/]//;
		if($s[$i] eq '01') {$vars[$i]++}
	}
}

saveF();

sub saveF
{
	open my $fd,">$fO";
	print $fd $res;
	close $fd;
}
