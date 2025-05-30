use strict;

my $fI='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CDS_Density.txt';
my $fO='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/CDS_mean.txt';

my $B=1000;
my $WS=100000;

open my $fd,$fI;
my @data=<$fd>;
close $fd;
shift @data;

my $res="chro\tm\tu\tl\n";

for(my $i=1;$i<30;$i++)
{
	my $bg=cac($i,\@data);

	my @bts;
	for(my $b=0;$b<$B;$b++)
	{
		my @bd;
		for(my $j=0;$j<=$#data;$j++)
		{
			push @bd,$data[int rand ($#data+1)];
		}
		push @bts,cac($i,\@bd);
	}
	@bts=sort {$a <=> $b} @bts;
	
	$res.="$i\t$bg\t$bts[975]\t$bts[25]\n";
	print "$i\t$bg\t$bts[975]\t$bts[25]\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;

sub cac
{
	(my $c,my $dt)=(@_);
	
	my $S;
	my $N;
	foreach my $d (@$dt)
	{
		$d=~s/\n//;
		my @s=split("\t",$d);
		if($s[0] == $c)
		{
			$N+=$WS;
			$S+=$s[2];
		}
	}
	my $m=$S/$N;
	return $m;
}


