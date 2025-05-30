use strict;

my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/CNV.txt';
my $multiF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/multigene.txt';
my $oF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/Grouppings.txt';

my %MULTI;
my %GR;
my $n=1;
open my $fd,$multiF;
while(<$fd>)
{
	if($_=~/V1/) {next}
	$_=~s/\n//g;
	$_=~s/\s{1,}/\t/g;

	my @s=split("\t",$_);

	$MULTI{$s[0]}=1;
	$MULTI{$s[1]}=1;

	my $ex='no';
	for(my $i=1;$i<=$n;$i++)
	{
		if($GR{$i}=~/$s[0]/ or $GR{$i}=~/$s[1]/)
		{
			$GR{$i}.="\t$s[0]\t$s[1]";
			$ex='yes';
		}				
	}
	if($ex eq 'no')
	{
		$GR{$n}="$s[0]\t$s[1]";
		$n++;
	}
}
close $fd;

my %TR;
my $t=1;
for(my $i=1;$i<$n;$i++)
{
	my @gt=split("\t",$GR{$i});
	
	my $est='no';
	for(my $i=1;$i<=$t;$i++)
	{
		foreach my $k (@gt)
		{
			if($TR{$i}=~/$k/)
			{
				$TR{$i}.="\t$k";
				$est='yes';
			}
		}
	}
	
	if($est eq 'no')
	{
		$TR{$t}=$GR{$i};
		$t++;
	}
}

for(my $i=1;$i<$t;$i++)
{
	my @gn=split("\t",$TR{$i});
	my %U;
	foreach my $g (@gn) {$U{$g}=1}
	$TR{$i}=join("\t",keys %U);
}

#print "$t\n";
#$t--;
#print "$t\n";
#exit;

open my $fd,$cnvF;
while(<$fd>)
{
	my @s=split("\t",$_);
	if($MULTI{$s[0]} !=1)
	{
		$TR{$t}=$s[0];		
		print "$t\n";
		$t++;
	}
}
close $fd;

my $res;
for(my $i=1;$i<$t;$i++)
{
	my @gn=split("\t",$TR{$i});
	my $nr=$#gn+1;
	$res.="g$i\t$nr\t$TR{$i}\n";
}


open my $fd,">$oF";
print $fd $res;
close $fd;

