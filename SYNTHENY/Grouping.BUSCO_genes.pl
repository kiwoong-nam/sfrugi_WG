use strict;

my $blastF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/BUSCO_Blast/busco.blastP';
my $OF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/BUSCO_genes';

my %BUSCO;
my $preID='d';
open my $fd,$blastF;
while(<$fd>)
{
	my @s=split("\t",$_);
	if($preID ne $s[0])
	{
		$BUSCO{$s[1]}=1;
		$preID=$s[0];
	}
}
close $fd;

my @genes=keys %BUSCO;
my $busco=join("\n",@genes);

open my $fd,">$OF";
print $fd $busco;
close $fd;




