use strict;

my $fileIn='/home/knam/work/sfrugi_WG/CNV_Gene/busco/buscoID_copies';
my $fileOut='/home/knam/work/sfrugi_WG/CNV_Gene/busco/busco_maxcopy';

my $res="ID\tmax_copies\n";

my $nsinglecopy=0;
my $nmulticopy=0;

open my $fd,$fileIn;
while(<$fd>)
{
	if($_=~/#/) {next}
	
	$_=~s/\n//;
	my @s=split("\t",$_);
	my $id=shift @s;
	my @NS=split(',',$s[0]);
	shift @NS;

	my $sres;
	my $singlecopy='yes';
	foreach my $is (@NS)
	{
		if($is>2){$sres="$_\n"}	
		if($is>1) {$singlecopy='no'}
	}

	if($sres ne "") {$res.=$sres;}

	if($singlecopy eq 'no') {$nmulticopy++}
	elsif($singlecopy eq 'yes') {$nsinglecopy++}
}
close $fd;

$res.="
# of single copy genes: $nsinglecopy
# of multi copy genes: $nmulticopy
";

open my $fd,">$fileOut";
print $fd $res;
close $fd;


