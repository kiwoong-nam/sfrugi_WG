use strict;

my $FI_intron='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Examples/geneFinding.txt';
my $FAWI='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/frugiperda.pos';
my $exiI='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/exigua.pos';
my $lituraI='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input/litura.pos';
my $orthochr_litura='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.orthochrom.litura';
my $orthochr_exigua='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/OrthoChr/BUSCO.orthochrom.exigua';

my $fO="/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Examples/examples.txt";

my %ortho_litura=orthoC($orthochr_litura);
my %ortho_exigua=orthoC($orthochr_exigua);

my %pos;
getINFO($lituraI);
getINFO($exiI);
getINFO($FAWI);

my %OR;
open my $fd,$FI_intron;
while(<$fd>)
{
	if($_=~/frugiperda/) {next}

	$_=~s/\n//g;
	my @s=split("\t",$_);
	my $cate=shift @s;
	my $og=shift @s;
	my $fru_id=shift @s;

	my @fru_pos=split("\t",$pos{$fru_id});
	my @litura_pos=split("\t",$pos{$s[0]});
	my @exigua_pos=split("\t",$pos{$s[1]});
	
	if($cate eq 'intronloss')
	{
		if($ortho_litura{$fru_pos[0]} ne $litura_pos[0] and $ortho_exigua{$fru_pos[0]} ne $exigua_pos[0]) {$OR{$og}++}
	}
	elsif($cate eq 'intronic')
	{
		if($ortho_litura{$fru_pos[0]} eq $litura_pos[0] and $ortho_exigua{$fru_pos[0]} eq $exigua_pos[0]) {$OR{$og}++}
	}
}

my @Os=keys %OR;
my %togo;

foreach my $g (@Os)
{
	if($OR{$g}==2) {$togo{$g}=1}
}

my $res;
open my $fd,$FI_intron;
while(<$fd>)
{
	if($_=~/frugiperda/) {next}

	$_=~s/\n//g;
	my @s=split("\t",$_);
	my $cate=shift @s;
	my $og=shift @s;
	unless($togo{$og} ==1) {next}
	$res.="$_\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;

sub orthoC
{
	(my $fI)=(@_);
	
	my %r;
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/\n//;

		if($_=~/frugiperda/) {next}
		my @s=split("\t",$_);
		$r{$s[0]}=$s[1]; # fro2others
	}
	close $fd;
	
	return %r;
}

sub getINFO
{
	(my $fI)=(@_);
	
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/\n//g;
		my @s=split("\t",$_);
		$s[0]=~s/\..$//;
		$pos{$s[0]}="$s[1]\t$s[2]\t$s[3]";
	}						
	close $fd;

}

