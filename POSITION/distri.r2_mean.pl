use strict;

my $B=1000;
my $fI='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2_summary';
my $ffai='/home/kiwoong/Projects/sfrugi_WG/SNV/ref/sfC.ver7.fa.fai';
my $fO='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2_mean';

my %chrS;
open my $fd,$ffai;
while(<$fd>)
{
	$_=~/HiC_scaffold_(\d+)/;
	my $chrN=$1;
	if($chrN>29) {next}
	my @s=split("\t",$_);
	$chrS{$chrN}+=$s[1];
}
close $fd;

my @N;
my @S;
my $prechr=0;
my $res="chrN\tchrSize\tm\tl\tu\n";
open my $fd,$fI;
while(<$fd>)
{
	if($_=~/rho_sum/) {next};
	$_=~s/\n//;
	my @s=split("\t",$_);
	if($s[0] !=$prechr)
	{
		if($prechr>0)
		{
			$res.="$prechr\t$chrS{$prechr}\t".calct(\@N,\@S)."\n";
		}
		undef @N;
		undef @S;
		$prechr=$s[0];
	}
	push @S,$s[2];
	push @N,$s[3];
}

$res.="$prechr\t$chrS{$prechr}\t".calct(\@N,\@S)."\n";

open my $fd,">$fO";
print $fd $res;
close $fd;

sub calct
{
	(my $n,my $s)=(@_);
	
	my $nsum;
	my $nn;
	for(my $i=0;$i<=$#$s;$i++)
	{
		$nsum+=$$s[$i];
		$nn+=$$n[$i];
	}
	my $bg=$nsum/$nn;

	my @bts;
	for(my $b=0;$b<$B;$b++)
	{
		my $Bnsum;
		my $Bnn;
		for(my $i=0;$i<=$#$s;$i++)
		{
			my $rp=int (rand ($#$s+1));
			$Bnsum+=$$s[$rp];
			$Bnn+=$$n[$rp];
		}
	
		my $bn=$Bnsum/$Bnn;
		push @bts,$bn;
	}
	
	@bts=sort {$a<=>$b} @bts;
	my $sre="$bg\t$bts[25]\t$bts[975]";
	return $sre;
}

