use strict;

my $WD='/home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884';

my $Idir="$WD/rawfq";
my $Odir="$WD/stats";

my $output="$Odir/throughput.txt";

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

my $res="ID\tnoseq\tlength\n";
foreach my $f (@files)
{
	unless($f=~/(\w+)_HiFi.fastq.gz/){next}
	my $id=$1;

	my $n;
	my $l=0;
	my $r=0;
	open my $fd,"zcat $Idir/$f |";
	while(<$fd>)
	{
		$n++;
		if($n%4==2)
		{
			chomp $_;
			$l+=length ($_);
			$r++;
		}
	}
	close $fd;
	print "$id\t$r\t$l\n";
	$res.="$id\t$r\t$l\n";
}

open my $fd,">$output";
print $fd $res;
close $fd;

