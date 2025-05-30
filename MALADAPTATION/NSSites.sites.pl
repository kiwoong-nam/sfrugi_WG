use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/res';
my $fO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/sites.txt';

my $res="i\tNS\tS\n";

for(my $i=1;$i<8522;$i++)
{
	my $fI="$inD/g$i.codeml";

	open my $fd,$fI;
	while(<$fd>)
	{	
		if($_=~/4\.\.1/)
		{
			$_=~s/ {1,}/\t/g;
			$_=~s/^\t//g;
			$_=~s/\t^//g;
			my @s=split("\t",$_);
			if($#s>4) {$res.="$i\t$s[2]\t$s[3]\n";}
		}
	}
	close $fd;
}

open my $fd,">$fO";
print $fd $res;
close $fd;
