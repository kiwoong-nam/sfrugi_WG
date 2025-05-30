use strict;

my $fHom1='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/Homo.txt';
my $fHom2='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/Homo2.txt';
my $fHet='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/Het.txt';
my $fO='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/calc.txt';

my $res;

my %Hom1=getS($fHom1);
my %Hom2=getS($fHom2);
my %Het=getS($fHet);

my @pos=sort{$a cmp $b} keys %Hom1;

my %C_Hom;
my %C_Het;

foreach my $ps (@pos)
{
	my @Hom1=split("\t",$Hom1{$ps});
	my @Hom2=split("\t",$Hom2{$ps});
	my @Het=split("\t",$Het{$ps});
	
	my $sres=$ps;
	for(my $i=0;$i<=$#Hom1;$i++)
	{
#		$sres.="\t".$Het[$i]/($Hom2[$i]+$Hom1[$i]);
		$sres.="\t".$Hom2[$i];
	}
	$sres.="\n";
	$res.=$sres;
}

open my $fd,">$fO";
print $fd $res;
close $fd;

sub getS
{
	(my $fI)=(@_);
	
	my %Dt;
	open my $fd,$fI;
	while(<$fd>)
	{
		if($_=~/chromosome/)
		{
			$res=$_;
			print $res;
			next;
		}

		$_=~s/\n//;
		my @s=split("\t",$_);
		my $c=shift @s;
		shift @s;
		$Dt{$c}=join("\t",@s);
	}
	close $fd;
	return %Dt;
}

