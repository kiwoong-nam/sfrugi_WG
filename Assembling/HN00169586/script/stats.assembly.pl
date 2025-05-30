use strict;

my $WD='/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586';

my $Idir="$WD/rawfq";
my $Odir="$WD/assemblies";
my $Gdir="$WD/polished";
my $Bdir="$WD/busco";

my $output="$WD/stats/assembly.txt";

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

my $res="assembly\tsize\tN50\tN90\ttnseq\n";

foreach my $f (@files)
{
	unless($f=~/(\w+)_HiFi.fastq.gz/){next}
	my $id=$1;
	my $assemblyF="$Gdir/$id.R3.fa";
	$res.=stats($assemblyF);
}

open my $fd,">$output";
print $fd $res;
close $fd;

sub stats
{
	(my $F)=(@_);
	my $length;
	my $totalLength;
	my @arr;
	
	$F=~/\w+\/[\w|\.]+$/;
	my $name=$&;
	$name=~s/\//_/;

	open my $fd,$F;
	my @files=<$fd>;

	foreach my $line (@files)
	{
		chomp $line;
		if($line=~/>/)
		{
			push (@arr, $length);
			$totalLength += $length;
			$length=0;
		}
		else
		{
			$length += length($line);
		}
	}
	close $fd;
	
	my @sort = sort {$b <=> $a} @arr;
	my $nseq=$#sort+1;
	my $n50;
	my $vn50;
	my $n90;
	my $vn90;

	L:foreach my $val(@sort)
	{
		$n50+=$val;

		if($n50 >= $totalLength/2)
		{
			$vn50=$val;
			last L;
		}
	}
	
	M:foreach my $val(@sort)
	{
 		$n90+=$val;

 		if($n90 >= $totalLength*0.9)
                {
                        $vn90=$val;
                        last M;
                }
        }

	$F=~s/^.*\///;
	my $res="$name\t$totalLength\t$vn50\t$vn90\t$nseq\n";
	print $res;
	return $res;
}






