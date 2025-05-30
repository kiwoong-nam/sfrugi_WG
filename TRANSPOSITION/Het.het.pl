use strict;

my $vcfF='/home/kiwoong/Projects/sfrugi_WG/SNV/vcf/FC.vcf.gz';
my $resF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Het/Het.txt';


my @hetero;
my $size;
my $res="chro\tsize\tsample\thetero\n";

my $chro="d";
open my $fd,"zcat $vcfF | ";
while(<$fd>)
{
	if($_=~/#/) {next}
	$_=~s/\n//g;	
	
	my @s=split("\t",$_);

	my $nv=0;
	while($s[4]=~/,/g) {$nv++}
	if($nv>2) {next}	    # only biallelic
	if($s[4]=~/\w{2,}/) {next}  # remove indel

	if($chro ne $s[0])
	{
		print "$s[0]\n";		
		if($#hetero>0)
		{
			for(my $i=0;$i<35;$i++)
			{
				$res.="$chro\t$size\t$i\t$hetero[$i]\n";
			}
			saveF();
		}
	
		$chro=$s[0];
		undef @hetero;
		undef $size;

	}

	$size=$s[1];

	for(my $i=9;$i<=$#s;$i++)
	{
		if($s[$i]=~/0[\/|\|]1/) {$hetero[($i-9)]++}
	}
}


for(my $i=0;$i<35;$i++)
{
	$res.="$chro\t$size\t$i\t$hetero[$i]\n";
}
saveF();

sub saveF
{
	open my $fd,">$resF";
	print $fd $res;
	close $fd;
}

