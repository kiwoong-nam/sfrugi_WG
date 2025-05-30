use strict;

my $ID="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR/afteralign";
my $OF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR/divergence.txt';

my $res="sample\tg\tc\tintact\td\n";

opendir my $D,$ID;
my @files=readdir($D);
close $D;

my $jn=0;
foreach my $f (@files)
{
	unless($f=~/\w/){next}

	my $gN=$f;
	$gN=~s/\.b.*$//;
	$gN=~s/^(.*)\.//;
	my $sample=$1;

	print "$jn $#files $sample\n";

	$jn++;
	my $id;
	my %SEQ;
	open my $fd,"$ID/$f";
	while(<$fd>)
	{
		$_=~s/\n//g;
		$_=~s/ //g;
		
		if($_=~/>(.*)/)
		{
			$id=$1;
		}
		else {$SEQ{$id}.=$_}
	}
	close $fd;
	
	my @ids=keys %SEQ;
	for(my $i=0;$i<=$#ids;$i++)
	{
		$ids[$i]=~/(\w+)\|(\w+)/;
		my $id=$1;
		my $nat=$2;
		my @da;
		for(my $j=0;$j<=$#ids;$j++)
		{
			if($j == $i) {next}
			my @S1=split("",$SEQ{$ids[$i]});
			my @S2=split("",$SEQ{$ids[$j]});
			my $n=0;
			my $d=0;
			for(my $p=0;$p<=$#S1;$p++)
			{
				$n++;
				if($S1[$p] ne '-' or $S2[$p] ne '-')
				{
					if($S1[$p] ne $S2[$p]) {$d++}
				}
			}
			my $div=$d/$n;	
			push @da,$div;
		}
		@da=sort{$a <=> $b} @da;
		$res.="$sample\t$gN\t$id\t$nat\t$da[0]\n";
	}
}

open my $fd,">$OF";
print $fd $res;
close $fd;
