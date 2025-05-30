use strict;
use List::Util qw/shuffle/;

my $inD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/cochr';
my $outF='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/perm.txt';
my $B=1000;

opendir my $D,$inD;
my @files=readdir($D);

my $res="sample\td\ts\tpval\n";
foreach my $f (@files)
{
	unless($f=~/F/) {next}
        
	my @b;
	my @s;
	my @d;
        
	open my $fd,"$inD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @single=split("\t",$_);
		if($_=~/both/) {push @b,$single[1]}
		if($_=~/single/) {push @s,$single[1]}
		if($_=~/diff/) {push @d,$single[1]}
	}
	close $fd;

	my $sres="$f\t".PERM(\@d,\@s)."\n";
        print "$sres";
	$res.=$sres;
}

open my $fd,">$outF";
print $fd $res;
close $fd;


sub PERM
{
	(my $v1,my $v2)=(@_);
	
	my @val1=@$v1;
	my @val2=@$v2;
	my @val=(@val1,@val2);

	my $m1=MN(@val1);
	my $m2=MN(@val2);

	my $diff=$m1-$m2;

	my $p=0;
	my @od=(0..$#val);

	for(my $b=0;$b<$B;$b++)
	{
		my @bod=shuffle(@od);
		my @vb1=@val[@bod[(0..$#val1)]];
		my @vb2=@val[@bod[(($#val1+1)..$#val)]];

		my $bdiff=MN(@vb1)-MN(@vb2);

		if($bdiff>=$diff){$p++}

	}
	$p=$p/$B;

	return "$m1\t$m2\t$p";
}

sub MN
{
	(my @vsl)=(@_);

	my $sum=0;
	foreach my $v (@vsl) {$sum+=$v}
	my $mn=$sum/($#vsl+1);
	
	return $mn;
}

	

