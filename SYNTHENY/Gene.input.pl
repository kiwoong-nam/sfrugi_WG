use strict;

#format: protein_id	faw_chr	original_chr

my $FAWI='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/frugiperda.pos';
my $exiI='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/exigua.pos';
my $lituraI='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/litura.pos';
my $orthoexi='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.orthochrom.exigua';
my $ortholit='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.orthochrom.litura';

my $fO_faw='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/input/faw';
my $fO_exigua='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/input/exigua';
my $fO_litura='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/input/litura';

##############

my %E2F=getO($orthoexi);
my %L2F=getO($ortholit);

my $res_faw;
open my $fd,$FAWI;
while(<$fd>)
{
	my @s=split("\t",$_);
	$res_faw.="$s[0]\t$s[1]\t$s[1]\n";
}
close $fd;

open my $fd,">$fO_faw";
print $fd $res_faw;
close $fd;

my $res_lit=getINFO($lituraI,\%L2F);
my $res_exi=getINFO($exiI,\%E2F);

open my $fd,">$fO_exigua";
print $fd $res_exi;
close $fd;

open my $fd,">$fO_litura";
print $fd $res_lit;
close $fd;

################################################################
################################################################

sub getINFO
{
	(my $fI,my $hs)=(@_);
	
	my $res;
	open my $fd,$fI;
	while(<$fd>)
	{
		my @s=split("\t",$_);
		my $fawc=$$hs{$s[1]};
		if($fawc eq "") {next}
		$res.="$s[0]\t$fawc\t$s[1]\n";
	}
	close $fd;
	return $res;
}

sub getO
{
	(my $fI)=(@_);
	
	my %p;
	open my $fd,$fI;
	while(<$fd>)
	{
		print $_;
		$_=~s/\n//;
		if($_=~/frugiperda/) {next}
		my @s=split("\t",$_);
		$p{$s[1]}=$s[0];
	}
	close $fd;
	$p{'Z'}='Z';	
	return %p;
}

