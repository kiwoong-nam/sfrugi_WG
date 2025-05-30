use strict;

my $rD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/readdepth/counts';
my $oF='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/mean.txt';
my $B=1000;

my @FC=qw(Upstream.CNV Upstream.nonCNV Intergenic Intron TE CDS_CNV CDS_nonCNV);
my @samples=qw(MORT2_MM1 MORT2_MM2 MORT2-MP MORT2-MR);

my $res="function\tsample\tm\tu\tl\n";
foreach my $cat (@FC)
{
	foreach my $sample (@samples)
	{
		my $FI="$rD/$sample.$cat.gz";
		my %S;
		my %N;
		open my $fd,"zcat $FI |";
		while(<$fd>)
		{
			$_=~s/\n//;	
			my @s=split("\t",$_);
			$N{$s[0]}++;
			if($s[2]>0) {$S{$s[0]}++}
		}
		close $fd;
		
		my @S;
		my @N;

		for(my $i=1;$i<30;$i++)
		{
			my $k="HiC_scaffold_$i";
			push @S,$S{$k};
			push @N,$N{$k};
		}

		my $bg=calcM(\@S,\@N);
				
		my @bts;
		for(my $b=0;$b<$B;$b++)
		{
			print "$cat $sample $b\n";
			my @bS;
			my @bN;
			for(my $c=0;$c<30;$c++)
			{
				my $k="HiC_scaffold_".(int rand 30);
				push @bS,$S{$k};
				push @bN,$N{$k};
			}

			push @bts,calcM(\@bS,\@bN);		
		}
		
		@bts=sort {$a <=> $b} @bts;	
		
		$res.="$cat\t$sample\t$bg\t$bts[975]\t$bts[25]\n";
	}
}
	
open my $fd,">$oF";
print $fd $res;
close $fd;

sub calcM
{
	(my $s,my $n)=(@_);
	
	my $ss;
	my $nn;
	for(my $i=0;$i<=$#$s;$i++)
	{
		$ss+=$$s[$i];
		$nn+=$$n[$i];
	}
	
	my $m=$ss/$nn;
	return $m
}




