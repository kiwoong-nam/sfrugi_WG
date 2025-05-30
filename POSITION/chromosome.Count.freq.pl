use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/cochr';
my $listF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $outF='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/freq.txt';
my $B=1000;

my %CNV;
open my $fd,$listF;
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	$CNV{$s[0]}=$s[1];
}
close $fd;

opendir my $D,$inD;
my @files=readdir($D);
close $D;

my $res="sample\ttype\tmn\tl\tu\n";

foreach my $f (@files)
{
	unless($f=~/F/) {next}
	
	my @data;
	open my $fd,"$inD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		my @single=split("\t",$_);
		push @data,$_;
	}
	close $fd;
	my @bg=CTS(@data);
	my @BB;
	my @BS;
	my @BD;

	for(my $b=0;$b<$B;$b++)
	{
		my @bdata;
		for(my $i=0;$i<=$#data;$i++)
		{
			push @bdata,$data[int rand ($#data+1)];
		}
		my @bres=CTS(@bdata);
		push @BB,$bres[0];
		push @BS,$bres[1];
		push @BD,$bres[2];
	}
	@BB=sort{$a <=> $b} @BB;
	@BS=sort{$a <=> $b} @BS;
	@BD=sort{$a <=> $b} @BD;

	$res.="$f\tinter+intra\t$bg[0]\t$BB[975]\t$BB[25]\n";
	$res.="$f\tintra\t$bg[1]\t$BS[975]\t$BS[25]\n";	
	$res.="$f\tinter\t$bg[2]\t$BD[975]\t$BD[25]\n";
}


open my $fd,">$outF";
print $fd $res;
close $fd;


sub CTS
{
	(my @d)=(@_);
	
	my $b=0;
	my $s=0;
	my $d=0;

	foreach my $v (@d)
	{
		if($v=~/both/) {$b++}
		if($v=~/single/) {$s++}
		if($v=~/diff/) {$d++}
	}

	return ($b,$s,$d);
}

