use strict;

my $fI='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/PI/SNP.windowed.pi';
my $fO='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/PI/SNP.mean';

my $B=1000;

my @data;
open my $fd,$fI;
while(<$fd>)
{
	$_=~/HiC_scaffold_(\d+)/;
	if($1>29) {next}
	$_=~s/\n//;
	my @s=split("\t",$_);
	push @data,$s[4];
}
close $fd;

my $bg=ct(@data);

my @B;
for(my $b=0;$b<$B;$b++)
{
	my @bd;
	for(my $i=0;$i<=$#data;$i++)
	{
		push @bd,$data[int rand ($#data+1)];
	}
	my $bv=ct(@bd);
	push @B,$bv;
}
@B=sort{$a <=> $b} @B;

my $res="mn\tu\tl\n$bg\t$B[975]\t$B[25]";

open my $fd,">$fO";
print $fd $res;
close $fd;



sub ct
{
	(my @dt)=(@_);
	
	my $S;
	my $n;
	foreach my $d (@dt)
	{
		$S+=$d;
		$n++;
	}
	my $n=$S/$n;
	return $n;
}

