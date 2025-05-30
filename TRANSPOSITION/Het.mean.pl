use strict;

my $fI='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/calc.txt';
my $fO='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/mean.txt';

my $res="chromosome\tm\tu\tl\n";

open my $fd,$fI;
while(<$fd>)
{
	if($_=~/chromosome/) {next}
	$_=~s/\n//;
	my @s=split("\t",$_);
	my $chrN=shift @s;
	
	(my $m,my $se)=ct(@s);
	my $u=$m+$se;
	my $l=$m-$se;
	
	$res.="$chrN\t$u\t$l\n";
}
close $fd;

print $res;

sub ct
{
	(my @d)=(@_);
	
	my $S;
	my $N;
	
	foreach my $v (@d)
	{
		$S+=$v;
		$N++;
	}
	my $mean=$S/$N;
	
	my $var;
	foreach my $v (@d)
	{
		$var+=(abs($mean-$v))*(abs($mean-$v));
	}
	my $sd=sqrt($var);
	my $se=$sd/sqrt($N);
	return($mean,$se);
}
