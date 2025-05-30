use strict;

my $fIi='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/intronN';
my $fO='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/intronloss';

my $res="OrthoID\tCNV.Ortho\tCNV.copy\tintronless\n";
open my $fd,$fIi;
while(<$fd>)
{
	my $cnv='nonCNV';
	if($_=~/yes/) {$cnv='CNV'}
		
	$_=~s/\n//;
	my @s=split("\t",$_);
	my @F=split(",",$s[2]);
	my @CNV=split(",",$s[1]);

	for(my $i=0;$i<=$#F;$i++)
	{
		my $intronless;
		if($F[$i]==1) {$intronless='yes'}
		elsif($F[$i]>1) {$intronless='no'}

		my $cnvO;
		if($CNV[$i] eq 'yes') {$cnvO='yes'}
		elsif($CNV[$i] eq 'no') {$cnvO='no'}

		unless($cnvO eq '') {$res.="$s[0]\t$cnv\t$cnvO\t$intronless\n"}
	}
}
close $fd;

open my $fd,">$fO";
print $fd $res;
close $fd;
