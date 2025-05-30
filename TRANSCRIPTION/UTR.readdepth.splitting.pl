use strict;

my $bedD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/readdepth/bed';
my $rD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/readdepth/counts';

my @FC=qw(CDS_CNV CDS_nonCNV Upstream.CNV Upstream.nonCNV Intergenic Intron TE);
my @samples=qw(MORT2_MM1 MORT2_MM2 MORT2-MP MORT2-MR);

foreach my $cat (@FC)
{
	my %FC;

	my $prechr="";	
	open my $fd,"$bedD/$cat.bed";
	L:while(<$fd>)
	{
		my @s=split("\t",$_);
		
		for(my $i=$s[1];$i<$s[2];$i++)
		{		
			my $k="$s[0]\t$i";
			$FC{$k}=1;
		}

		if($s[0] ne $prechr)
		{
			print "reading files of $cat in $s[0]\n";
			$prechr=$s[0];
		}
	}
	close $fd;

	foreach my $sample (@samples)
	{
		my $oF="$rD/$sample.$cat";

		my $rpr;
		open my $fd,"zcat $rD/$sample.gz |";
		while(<$fd>)
		{
			if($_=~/#/) {next}
			my @s=split("\t",$_);
			my $k="$s[0]\t$s[1]";
			if($FC{$k}==1) {$rpr.=$_}
			if($s[0] ne $prechr)
			{
				print "treating $sample for $cat in $s[0]\n";
				$prechr=$s[0];
			}
		}
		close $fd;
		
		open my $fd,">$oF";
		print $fd $rpr;
		close $fd;
		
		`gzip -f $oF`;
	}
	undef %FC;

}




