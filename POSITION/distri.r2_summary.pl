use strict;

my $DI='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2';
my $fO='/home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2_summary';

my $WS=100000;

my $res="chro\tstart\trho_sum\tnSNP\n";
for(my $i=1;$i<30;$i++)
{
	print "chr$i\n";
	my %S;
	my %N;
	my $lW=0;
	open my $fd,"zcat /home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2/$i.hap.ld.gz | ";
	while(<$fd>)
	{
		if($_=~/na/) {next}
		my @s=split("\t",$_);
		my $W=int ($s[1]/$WS);
		$S{$W}+=$s[4];
		$N{$W}++;
		$lW=$W;
	}
	close $fd;
	
	for(my $p=0;$p<$lW;$p++)
	{
		$res.="$i\t$p\t$S{$p}\t$N{$p}\n";
	}

	open my $fd,">$fO";
	print $fd $res;
	close $fd;
}

