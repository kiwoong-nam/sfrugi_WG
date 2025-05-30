use strict;

my $vcfF="/home/kiwoong/Projects/sfrugi_WG/SNV/vcf/FC.filtered.phased.vcf.gz";
my $WS=100000;

for(my $i=1;$i<30;$i++)
{
	print "$i\n";
	`tabix -h $vcfF HiC_scaffold_$i  | vcftools --vcf - --hap-r2 --out /home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2/$i`;
	`gzip -f  /home/kiwoong/Projects/sfrugi_WG/POSITION/distri/r2/$i.hap.ld`;
}


