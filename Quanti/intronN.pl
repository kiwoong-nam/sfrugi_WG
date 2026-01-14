use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';
my @sample=qw(FC01  FC03  FC_100  FC_102  FC_104  FC_106  FC33  FC37  FC54  FC71  FC76  FC78  FC81  FC_84  FC_88  FC_90  FC_95  FC_98 FC02  FC04  FC_101  FC_103  FC_105  FC32  FC35  FC52  FC55  FC72  FC77  FC79  FC82  FC_85  FC_89  FC_92  FC_97  FC_99);

my $outD='/home/kiwoong/Projects/sfrugi_WG/Quanti/intronN';

for(my $i=0;$i<=$#sample;$i++)
{
	my $fI="$inD/$sample[$i]";
	my $output="$outD/$sample[$i]";

	my $res;
	open my $fd,$fI;
	while(<$fd>)
	{
		unless($_=~/\tCNV\t/) {next}
		unless($_=~/\tintact\t/) {next}
		$_=~s/\n//;
		$_=~/^\w+/;
		my $id=$&;
		if($_=~/\t0$/) {$res.="$id\tintronless\n"}
		else {$res.="$id\tintronic\n"}

	}
	close $fd;

	open my $fd,">$output";
	print $fd $res;
	close $fd;
}

