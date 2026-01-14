use strict;

my $WD='/home/kiwoong/Projects/sfrugi_WG/Quanti';
my $FO="$WD/indicatorN.txt";

my @sample=qw(FC01  FC03  FC_100  FC_102  FC_104  FC_106  FC33  FC37  FC54  FC71  FC76  FC78  FC81  FC_84  FC_88  FC_90  FC_95  FC_98 FC02  FC04  FC_101  FC_103  FC_105  FC32  FC35  FC52  FC55  FC72  FC77  FC79  FC82  FC_85  FC_89  FC_92  FC_97  FC_99);

my $res="sample\tindicator\tproportion\ttotal\n";

for(my $i=0;$i<=$#sample;$i++)
{
	my $LINE="$WD/LINE/$sample[$i]";
	my $Distal="$WD/Distal/$sample[$i]";
	my $intronN="$WD/intronN/$sample[$i]";

	my %genes;
	my %tg;
	open my $fd,$LINE;
	while(<$fd>)
	{
		$_=~s/\n//g;
		my @s=split("\t",$_);
		if($s[1] eq 'line') {$genes{$s[0]}++}
		$tg{$s[0]}=1;
	}
	close $fd;

	open my $fd,$Distal;
	while(<$fd>)
	{
		$_=~s/\n//g;
		my @s=split("\t",$_);
		if($s[1] eq 'inter') {$genes{$s[0]}++}
		$tg{$s[0]}=1;
	}
	close $fd;

	open my $fd,$intronN;
	while(<$fd>)
	{
		$_=~s/\n//g;
		my @s=split("\t",$_);
		if($s[1] eq 'intronless') {$genes{$s[0]}++}
		$tg{$s[0]}=1;
	}

	my @gs=keys %tg;

	my $total;
	my $n3=0;
	my $n2=0;
	my $n1=0;

	foreach my $g (@gs)
	{
		$total++;
		if($genes{$g}==3) {$n3++}
		if($genes{$g}>1) {$n2++}
		if($genes{$g}>0) {$n1++}
	}
	my $p3=$n3/$total;
	my $p2=$n2/$total;
	my $p1=$n1/$total;

	$res.="$sample[$i]\t1\t$p1\t$total\n"."$sample[$i]\t2\t$p2\t$total\n"."$sample[$i]\t3\t$p3\t$total\n";
}

open my $fd,">$FO";
print $fd $res;
close $fd;

