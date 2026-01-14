use strict;

exts('litura');
exts('exigua');

sub exts
{
	(my $sp)=(@_);

	my $input="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/DAGChainer/pairwise_blast.aligncoords.BUSCO.$sp";
	my $oF1="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.orthochrom.$sp";
	my $oF2="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.deviation.$sp";
	my $oF3="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.genes.$sp";

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
	}
	close $fd;

	my @chrs=keys %GR;
	my $res="frugiperda\t$sp\n";

	foreach my $c (@chrs) {$res.="$c\t$GR{$c}\n"}

	my $dev;
	my $ndev;
	my $ntotal;
	my $nl;
	open my $fd,$input;
	while(<$fd>)
	{
		my @s=split("\t",$_);	
		my $fruchr;
		my $frust;
		my $frund;
		my $litchr;
		my $litst;
		my $lited;

		if($s[1]=~/\./)
		{
			$litchr=$s[0];
			$litst=$s[2];
			$lited=$s[3];

			$fruchr=$s[4];
			$frust=$s[6];
			$frund=$s[7];
		}
		elsif($s[5]=~/\./)
		{
			$litchr=$s[4];
			$litst=$s[6];
			$lited=$s[7];

			$fruchr=$s[0];
			$frust=$s[2];
			$frund=$s[3];

		}
		if($GR{$fruchr} ne $litchr and $GR{$fruchr} ne "" )
		{
			$ndev++;
			$dev.=$_;
		}
		
		$nl.="$fruchr\t$frust\t$frund\t$litchr\t$litst\t$lited\n";
		
		$ntotal++;
	}
	close $fd;

	my $p=$ndev/($ndev+$ntotal);
	print "$sp\nN.dev: $ndev\nN.total: $ntotal\nprop of dev: $p\n\n\n";
	
	open my $fd,">$oF1";
	print $fd $res;
	close $fd;

	open my $fd,">$oF2";
	print $fd $dev;
	close $fd;

	open my $fd,">$oF3";
	print $fd $nl;
	close $fd;
}

#litura
#N.dev: 403
#N.total: 3513
#prop of dev: 0.10291113381001


#exigua
#N.dev: 49
#N.total: 3636
#prop of dev: 0.0132971506105834


