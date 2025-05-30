use strict;

my $filein='/home/knam/work/sfrugi_WG/CNV_Gene/busco/buscoID';
my $fileout='/home/knam/work/sfrugi_WG/CNV_Gene/busco/buscoID_copies';

my @samples=qw(FC01  FC03  FC_100  FC_102  FC_104  FC_106  FC33  FC37  FC54  FC71  FC76  FC78  FC81  FC_84  FC_88  FC_90  FC_95  FC_98 FC02  FC04  FC_101  FC_103  FC_105  FC32    FC35  FC52  FC55  FC72  FC77  FC79  FC82  FC_85  FC_89  FC_92  FC_97  FC_99);

my $Bres="#ID\t".join(",",@samples)."\n";
open my $fd,$filein;
while(<$fd>)
{
	$_=~s/\n//;
	$_=~s/^\w+//;
	my $res=$&."\t";
	foreach my $s (@samples)
	{
		my $n=0;
		while($_=~/$s/g){$n++}
		$res.="$n,";
	}
	$res.="\n";
	$Bres.=$res;
	print $res;
}

open my $fd,">$fileout";
print $fd $Bres;
close $fd;
