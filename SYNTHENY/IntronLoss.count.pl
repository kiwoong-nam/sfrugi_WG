use strict;

my $fIi='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/intronN';
my $fIc='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/chrN';
my $fO='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/IntronLoss/counting';

my %Intronless;
open my $fd,$fIi;
while(<$fd>)
{
#	if($_=~/yes/) {next}
		
	$_=~s/\n//;
	my @s=split("\t",$_);
	my @F=split(",",$s[2]);
	my @L=split(",",$s[3]);
	my @E=split(",",$s[4]);
	
	my $Outgroup_intronless='yes';
	foreach my $l (@L) {if($l>1) {$Outgroup_intronless='no'}}
	foreach my $l (@E) {if($l>1) {$Outgroup_intronless='no'}}
	
	for(my $i=0;$i<=$#F;$i++)
	{
		my $key="$s[0]\t$i";
		my $answer;
		
		if($Outgroup_intronless eq 'no')
		{
			if($F[$i]>1) {$answer='intronic'} ## having introns
			elsif($F[$i]==1) {$answer='intronloss'}  ## loss of intron after split
		}
		elsif($Outgroup_intronless eq 'yes')
		{
			if($F[$i]>1) {$answer='intronic'} ## having introns
			elsif($F[$i]==1) {$answer='sustaintroless'} ## keep having no introns
		}
		
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

print $res;	
open my $fd,">$fO";
print $fd $res;
close $fd;
