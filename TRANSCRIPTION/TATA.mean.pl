use strict;

my $ID='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/counts';
my $oF='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/mean';
my $B=1000;

my $res="sample\tFunc\tn\tm\tl\tu\n";

my @FC=qw(CNV nonCNV);

foreach my $f (@FC)
{
	my $inD="$ID/$f";
	
	opendir my $D,$inD;
	while(readdir($D))
	{
		unless($_=~/\w/){next}

		my $sample=$_;
		
		my @data;
		my $n=0;
		my $iF="$inD/$sample";
		open my $fd,$iF;
		while(<$fd>)
		{
			if($_=~/yes/) {push @data,1}
			elsif($_=~/no/) {push @data,0}
			$n++;
		}
		close $fd;

		my $m=getM(@data);
		
		my @bmean;
		for(my $b=0;$b<$B;$b++)
		{
			my @bd;
			for(my $i=0;$i<=$#data;$i++)
			{
				push @bd,$data[int rand ($#data+1)];
			}
			my $bc=getM(@bd);
			push @bmean,$bc;
		}
		@bmean=sort {$a<=>$b} @bmean;
		my $sres="$sample\t$f\t$n\t$m\t$bmean[25]\t$bmean[975]\n";
		print $sres;
		$res.=$sres;
	}
	close $D;
}
	
open my $fd,">$oF";
print $fd $res;
close $fd;


sub getM
{
	(my @V)=(@_);
	
	my $s;
	foreach my $val (@V) {$s+=$val}
	my $mn=$s/($#V+1);
	return $mn;
}
