use strict;

my $fIi='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/intronN';
my $fIc='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/chrN';
my $fO='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/counting';

my %Intronless;
open my $fd,$fIi;
while(<$fd>)
{
#	if($_=~/yes/) {next}
		
	$_=~s/\n//;
	my @s=split("\t",$_);
	my @F=split(",",$s[2]);
	
	for(my $i=0;$i<=$#F;$i++)
	{
		my $key="$s[0]\t$i";
		my $answer;
		if($F[$i]>1) {$answer='intron'}
		elsif($F[$i]==1) {$answer='intronless'}
		$Intronless{$key}=$answer;
	}
}
close $fd;

my $res;
open my $fd,$fIc;
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	my @FT=split(",",$s[2]);
	my @FCNV=split(",",$s[1]);

	my @L=split(",",$s[3]);
	my @E=split(",",$s[4]);

	for(my $i=0;$i<=$#FT;$i++)
 	{
#		if($FCNV[$i] eq 'yes') {next}

		my $key="$s[0]\t$i";
	      	my $intron=$Intronless{$key};
		if($intron eq '') {next}

  		my $v1m='nonconserv';
		foreach my $v (@L)
		{
			if($v eq $FT[$i]) {$v1m='conserv'}
		}

		my $v2m='nonconserv';
		foreach my $v (@E)
		{
			if($v eq $FT[$i]) {$v2m='conserv'}
		}

		if($v1m eq $v2m)
		{
			$res.="$intron\t$v1m\n";

		}
	}
}

open my $fd,">$fO";
print $fd $res;
close $fd;
