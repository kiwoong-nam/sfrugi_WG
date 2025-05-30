use strict;

exts('litura');
exts('exigua');

sub exts
{
	(my $sp)=(@_);

	my $input="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/DAGChainer/pairwise_blast.aligncoords.BUSCO.$sp";
	my $oF1="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.orthochrom.$sp";
	my $oF2="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.deviation.$sp";

	my $dev;
	my %GR;
	open my $fd,$input;
	while(<$fd>)
	{
		my @s=split("\t",$_);
	
		my $fruchr;
		my $litchr;
	
		if($s[1]=~/\./)
		{
			$litchr=$s[0];
			$fruchr=$s[4];
		}
		elsif($s[5]=~/\./)
		{
			$fruchr=$s[0];
			$litchr=$s[4];
		}
	
		$GR{$fruchr}=$litchr;
	
		if($GR{$fruchr} ne $litchr){$dev.=$_;}
	}
	close $fd;

	my @chrs=keys %GR;
	my $res="frugiperda\t$sp\n";

	foreach my $c (@chrs)
	{
		$res.="$c\t$GR{$c}\n";
	}

	open my $fd,">$oF1";
	print $fd $res;
	close $fd;

	open my $fd,">$oF2";
	print $fd $dev;
	close $fd;
}
