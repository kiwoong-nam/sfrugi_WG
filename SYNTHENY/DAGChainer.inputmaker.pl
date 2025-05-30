use strict;

my $WD='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer';

my %POS;
execA('litura');
undef %POS;
execA('exigua');

sub execA
{
	(my $sp)=(@_);

	my $fileIn="$WD/fx/allvsall.$sp";
	my $fruP="$WD/input/frugiperda.pos";
	my $litpos="$WD/input/$sp.pos";
	my $fileOut="$WD/input/pairwise_blast.$sp";

	getpos($fruP);
	getpos($litpos);

	my $res;
	open my $fd,$fileIn;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		pop @s;
		my $ev=pop @s;
	
		my @l=split("\t",$POS{$s[0]});
		my @f=split("\t",$POS{$s[1]});
	
		if($#l == -1) {next}
		if($#f == -1) {next}

		$res.="$l[0]\t$s[0]\t$l[1]\t$l[2]\t$f[0]\t$s[1]\t$f[1]\t$f[2]\t$ev\n";
	}
	close $fd;

	open my $fd,">$fileOut";
	print $fd $res;
	close $fd;
}

sub getpos
{
	(my $pF)=(@_);
	
	open my $fd,$pF;
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		$POS{$s[0]}="$s[1]\t$s[2]\t$s[3]";
	}
	close $fd;
}

