use strict;

my $fI1='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups_function_curated';
my $fI2='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/groups_function';
my $fI3='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/proportion.txt';
my $fI4='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/list.txt';
my $fO='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';

my %TE;
open my $fd,$fI3;
while(<$fd>)
{
	$_=~s/\n//g;
	my @s=split("\t",$_);
	if($s[1] > 0.9) {$TE{$s[0]}=1}	
}
close $fd;

my %CNV;
open my $fd,$fI1;
while(<$fd>)
{
	$_=~s/\n//g;
	my @s=split("\t",$_);
	
	shift @s;
	my $func='GENE';
	shift @s;
	foreach my $g (@s) {$CNV{$g}=$func}
	
}
close $fd;

open my $fd,$fI2;
while(<$fd>)
{
	$_=~s/\n//g;
	my @s=split("\t",$_);
	
	shift @s;
	shift @s;
	foreach my $g (@s) 
	{
		if($CNV{$g} eq "") {$CNV{$g}="TE"}
	}
}
close $fd;

my $res;
open my $fd,$fI4;
while(<$fd>)
{
	if($_=~/#/) {next}
	$_=~s/\n//g;
	my @s=split("\t",$_);
	
	my $id=shift @s;
	
	my $cate;
	if($_=~/yes/)
	{
		if($CNV{$id} eq "TE") {$cate='CNV.TE'}
		elsif($CNV{$id} eq "GENE") {$cate='CNV.GENE'}
		elsif($TE{$id} == 1) {$cate ='EXCL.TE'}
		else {$cate='EXCL.GENE'}
	}
	else
	{
		my @cps=split(",",$s[0]);
		my $multi;
		foreach my $line (@cps) {if($line > 1) {$multi='yes'}}
	
		if($multi eq 'yes')
		{
			if($TE{$id} == 1) {$cate ='EXCL.TE'}
			else {$cate ='EXCL.GENE'}
		}
		else
		{
			if($TE{$id} == 1) {$cate ='nonCNV.TE'}
			else {$cate ='nonCNV.GENE'}
		}
	}
	$res.="$id\t$cate\n";
}
close $fd;

open my $fd,">$fO";
print $fd $res;
close $fd;

