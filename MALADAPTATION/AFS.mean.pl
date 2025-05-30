use strict;

my $FI='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/AFS/counts';
my $FO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/AFS/mean';
my $B=1000;

open my $fd,$FI;
my @dataT=<$fd>;
close $fd;

shift @dataT;

my $res="CNV\tNS\tx\tmn\tu.ci\tl.ci\n";
TES("CNV");
TES("NONCNV");

sub TES
{
	(my $t)=(@_);

	my @data;
	foreach my $i (@dataT)
	{
		my @s=split("\t",$i);
		
		if($s[0] eq $t)
		{
			push @data,$i;
		}
	}

	my @bg=cals(@data);


	my @BTR_n;
	my @BTR_s;

	for(my $b=0;$b<$B;$b++)
	{
		print "$t $b\n";
		my @rD;
		for(my $i=0;$i<=$#data;$i++)
		{
			push @rD,$data[int rand ($#data+1)];
		}
		my @bt=cals(@rD);
		push @BTR_n,$bt[0];
		push @BTR_s,$bt[1];
	}

	$res.=sumR(0,\@BTR_n,$t,'N',\@bg);
	$res.=sumR(1,\@BTR_s,$t,'S',\@bg);

	print "$res\n";
	open my $fd,">$FO";
	print $fd $res;
	close $fd;
}


sub sumR
{
	(my $cl,my $BTR,my $cnv,my $NS,my $bgD)=(@_);

	my $sres;
	my @bgR=@{$$bgD[$cl]};
	for(my $i=0;$i<35;$i++)
	{
		my $bg=$bgR[$i];

		my @bts;
		foreach my $bv (@$BTR){push @bts,${$bv}[$i];}
		@bts=sort {$a <=> $b} @bts;

		my $k=$i+1;
		$sres.="$cnv\t$NS\t$k\t$bg\t$bts[975]\t$bts[25]\n";
	}

	print $sres;
	return $sres;
}


sub cals
{
	(my @dt)=(@_);
	
	my @S;
	my @N;
	
	for(my $i=0;$i<35;$i++)
	{
		push @S,0;
		push @N,0;
	}

	foreach my $d (@dt)
	{
		$d=~s/\n//;
		my @single=split("\t",$d);
		my @NS=split(",",$single[1]);
		my @SS=split(",",$single[2]);

		for(my $i=0;$i<35;$i++)
		{
			$N[$i]+=$NS[$i];
			$S[$i]+=$SS[$i];
		}
	}

	my $s=0;
	foreach my $v (@S) {$s+=$v}
	my $n=0;
	foreach my $v (@N) {$n+=$v}

	for(my $i=0;$i<35;$i++)
	{
		$N[$i]=$N[$i]/$n;
		$S[$i]=$S[$i]/$s;
	}

	return (\@N,\@S);
}
