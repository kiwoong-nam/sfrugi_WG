use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/chromosome';
my $outD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/cochr';

my $res="sample\ttype\tmn\tl\th\n";

opendir my $D,$inD;
while(readdir($D))
{
	unless($_=~/^(.*)\.chrs\.dupl/) {next}
	my $sample=$1;
	
	my $outF="$outD/$sample";

	open my $fd,"$inD/$_";
	my @data=<$fd>;
	close $fd;

	my $res;
	foreach my $line (@data)
	{
		$line=~s/\n//g;
		my @single=split("\t",$line);

		my $df='diff';
		my @s=split(",",$single[1]);
		if($#s==0)
		{
			$df='unknown';
		}
		else
		{
			K:for(my $i=0;$i<=$#s;$i++)
			{
				for(my $j=0;$j<=$#s;$j++)
				{
					if($s[$i] == $s[$j] and $i != $j)
					{
						$df="single";
						last K;
					}
				}
			}
			L:for(my $i=0;$i<=$#s;$i++)
			{
				for(my $j=1;$j<=$#s;$j++)
				{
					if($s[$i] != $s[$j] and $i != $j and $df eq 'single')
					{
						$df="both";
						last L;
					}
				}
			}
		}
		my $nr=$#s+1;
		$res.="$single[0]\t$nr\t$df\n";
	}
	open my $fd,">$outF";
	print $fd $res;
	close $fd;

}

