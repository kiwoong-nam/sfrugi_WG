use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/cochr';
my $listF='/home/kiwoong/Projects/sfrugi_WG/POSITION/CNVTE/list.txt';
my $outF='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/copy.txt';

my $B=1000;

opendir my $D,$inD;
my @files=readdir($D);
close $D;

my $res="cate\tsample\ttype\tmean\tmn\tl\tu\n";

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
	$res.="$f\tboth\t".SD(@b)."\n";
	$res.="$f\tsingle\t".SD(@s)."\n";
	$res.="$f\tdifferent\t".SD(@d)."\n";
}

open my $fd,">$outF";
print $fd $res;
close $fd;


sub SD
{
	(my @val)=(@_);
	
	my $sum=0;
	foreach my $v (@val) {$sum+=$v}
	my $mn=$sum/($#val+1);
	
	my @bs;
	for($b=0;$b<$B;$b++)
	{
		my $bts=0;
		for(my $i=0;$i<=$#val;$i++)
		{
			$bts+=$val[int rand $#val];	
		}
		$bts=$bts/($#val+1);
		push @bs,$bts;
	}	
	@bs=sort{$a<=>$b} @bs;
	
	return "$mn\t$bs[25]\t$bs[975]";
}	
	

