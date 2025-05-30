use strict;

my $fileIn='/home/knam/work/sfrugi_WG/CNV_Gene/busco/buscoID_copies';
my $fileOut='/home/knam/work/sfrugi_WG/CNV_Gene/busco/busco_secondallele';

my %FC;
open my $fd,$fileIn;
while(<$fd>)
{
	if($_=~/#/) {next}
	
	$_=~s/\n//;
	my @s=split("\t",$_);
	my $id=shift @s;
	my @NS=split(',',$s[0]);
	shift @NS;

	my %CT;
	foreach my $is (@NS) {$CT{$is}++}
	my @als=sort {$a <=> $b} keys %CT;

	my @AFSF;
	foreach my $af (@als) { push @AFSF,$CT{$af}}
	@AFSF=sort {$b <=> $a} @AFSF;
	shift @AFSF;
	my $secondallele=shift @AFSF;
	if($secondallele eq '') {$secondallele=0}

	$FC{$secondallele}++;
}
close $fd;

my $res="x\tcounts\n";
for(my $i=0;$i<39;$i++)
{
	my $cti=$FC{$i};
	if($cti eq '') {$cti=0};
	$res.="$i\t$cti\n";	
}

open my $fd,">$fileOut";
print $fd $res;
close $fd;


