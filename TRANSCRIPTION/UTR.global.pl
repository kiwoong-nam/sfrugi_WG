use strict;
use List::Util qw/shuffle/;

my $rD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/readdepth/counts';
my $fO='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/global.txt';
my $B=1000;

my @FC=qw(Upstream.CNV Upstream.nonCNV Intergenic Intron TE CDS_CNV CDS_nonCNV);
my @samples=qw(MORT2_MM1 MORT2_MM2 MORT2-MP MORT2-MR);

my $res="func\tsample\tm.func\tm.nfunc\tnm.func\tnm.nfunc\n";

foreach my $cat (@FC)
{
	foreach my $sample (@samples)
	{
		my $FS="$rD/$sample.$cat.gz";
		my $FC1="$rD/$sample.Intergenic.gz";
		my $FC2="$rD/$sample.Intron.gz";
		my $FC3="$rD/$sample.TE.gz";
			
		print "For $cat in $sample, read FC\n";		  

		my ($m_func,$nm_func,$m_nfunc,$nm_nfunc)=0;
		open my $fd,"zcat $FS |";
		while(<$fd>)
		{
			$_=~s/\n//;
			my @s=split("\t",$_);
			if($s[2] > 0) {$m_func++}
			else {$nm_func++}
		}
		close $fd;
		print "$cat\t$sample\t$m_func\t$nm_func\t$m_nfunc\t$nm_nfunc\n";
		
		print "For $cat in $sample, read Intergenic\n";		  

		open my $fd,"zcat $FC1 |";
		while(<$fd>)
		{
			$_=~s/\n//;
			my @s=split("\t",$_);
			if($s[2] > 0) {$m_nfunc++}
			else {$nm_nfunc++}
		}
		close $fd;
		print "$cat\t$sample\t$m_func\t$nm_func\t$m_nfunc\t$nm_nfunc\n";
			
		print "For $cat in $sample, read Intronic\n";		  
		open my $fd,"zcat $FC2 |";
		while(<$fd>)
		{
			$_=~s/\n//;
			my @s=split("\t",$_);
			if($s[2] > 0) {$m_nfunc++}
			else {$nm_nfunc++}
		}
		close $fd;
		print "$cat\t$sample\t$m_func\t$nm_func\t$m_nfunc\t$nm_nfunc\n";

		print "For $cat in $sample, read TE\n";		  
		open my $fd,"zcat $FC3 |";
		while(<$fd>)
		{
			$_=~s/\n//;
			my @s=split("\t",$_);
			if($s[2] > 0) {$m_nfunc++}
			else {$nm_nfunc++}
		}
		close $fd;

		$res.="$cat\t$sample\t$m_func\t$nm_func\t$m_nfunc\t$nm_nfunc\n";
		print "final: $cat\t$sample\t$m_func\t$nm_func\t$m_nfunc\t$nm_nfunc\n";

		open my $fd,">$fO";
		print $fd $res;
		close $fd;
	}
}
