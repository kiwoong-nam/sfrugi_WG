use strict;

my $fI='/home/kiwoong/Projects/sfrugi_WG/POSITION/Intronless/count.txt';
my $fO='/home/kiwoong/Projects/sfrugi_WG/POSITION/Intronless/prop.txt';
my $B=1000;

open my $fd,$fI;
my @data=<$fd>;
shift @data;

my @bg=cts(@data);

my @bts;
for(my $b=0;$b<$B;$b++)
{
	print "$b\n";
	my @bd;
	for(my $i=0;$i<=$#data;$i++)
	{
		push @bd,$data[int rand ($#data+1)];
	}
	
	my @bt=cts(@bd);

	for(my $i=1;$i<30;$i++)
	{
		$bts[$i].="$bt[$i]\n";
	}
}

my $res="chrN\tm\tl\tu\n";
for(my $i=1;$i<30;$i++)
{
	my @boot=split("\n",$bts[$i]);
	@boot=sort {$a <=> $b} @boot;
	$res.="$i\t$bg[$i]\t$boot[25]\t$boot[975]\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;


sub cts
{
	(my @d)=(@_);
	
	my %chA;
	my %chS;
	foreach my $dt (@d)
	{
		$dt=~s/\n//;
		my @ds=split("\t",$dt);
		if($ds[2]==1) {$chS{$ds[1]}++}
		$chA{$ds[1]}++;
	}
	
	my @rs;
	for(my $i=1;$i<30;$i++)
	{
		$rs[$i]=$chS{$i}/$chA{$i}
	}
	return @rs;
}

