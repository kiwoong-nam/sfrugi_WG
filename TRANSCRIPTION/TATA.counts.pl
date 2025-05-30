use strict;

my $SeqD="/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/Seqs";
my $OD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/counts';
my @FC=qw(CNV nonCNV);

foreach my $f (@FC)
{
	my $inD="$SeqD/$f";
	my $outD="$OD/$f";
	
	opendir my $D,$inD;
	while(readdir($D))
	{
		unless($_=~/\w/){next}

		my $sample=$_;
		
		my $iF="$inD/$sample";
		my $oF="$outD/$sample";
		print "$oF\n";
			
		my $id;
		my $tata;
		my $res;
		open my $fd,$iF;
		while(<$fd>)
		{
			$_=~s/\n//;
			if($_=~/>(.*)$/) {$id=$1}
			else
			{
				if($_=~/TATA[A|T]A[A|T]/) {$tata='yes'}
				else{$tata='no'}
				$res.="$id\t$tata\n";
			}
		}
		close $fd;

	
		open my $fd,">$oF";
		print $fd $res;
		close $fd;
	}
	close $D;
}
