use strict;

my $cF='/home/knam/work/sfrugi_WG/SYNTHENY/Gene/singleortholog/chrN';
my $iF='/home/knam/work/sfrugi_WG/SYNTHENY/Gene/singleortholog/intronN';
my $fO='/home/knam/work/sfrugi_WG/SYNTHENY/Gene/singleortholog/merged';

my %I;

open my $fd,$iF;
while(<$fd>)
{
	$_=~/\w+/;
	my $id=$&;

	$_=~s/\n//;

	my @s=split("\t",$_);
	if($s[1]==0 and $s[2] > 0 and $s[3] > 0)
	{
		$I{$id}='intronless'
	}
	else {$I{$id}='intron'}
}

my $res="gene\tintron\tsyntheny\n";
open my $fd,$cF;
while(<$fd>)
{
	if($_=~/gene/) {next}
	$_=~s/\n//;
	my @s=split("\t",$_);
	
	my $cons;
	if($s[1] ne $s[2] and $s[2] eq $s[3]) {$cons='nonconserv';print "@s\n"}
	else {$cons='conserv'}
	
	my $sR="$s[0]\t$I{$s[0]}\t$cons\n";
	$res.=$sR;
}

open my $fd,">$fO";
print $fd $res;
close $fd;

