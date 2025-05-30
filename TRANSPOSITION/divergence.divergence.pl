use strict;

my $ID="/home/knam/work/sfrugi_WG/TRANSPOSITION/divergence/afteralign";
my $OF='/home/knam/work/sfrugi_WG/TRANSPOSITION/divergence/divergence.txt';

my $res="g\td1\td2\td3\tn\tdiv1\tdiv2\tdiv3\tn\n";

opendir my $D,$ID;
my @files=readdir($D);
close $D;

my $op=0;
foreach my $f (@files)
{
	unless($f=~/gb$/) {next}

	$op++;
	print "$op\n";
	my $fI="$ID/$f";
	my $i=$f;
	$i=~s/\.b.*$//;
	my $id;
	my %SEQ;
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/\n//g;
		$_=~s/ //g;
		
		if($_=~/>(\w+)/) {$id=$1}
		else {$SEQ{$id}.=$_}
	}
	close $fd;
	
	my $n=0;
	my @d=(0,0,0);

	my @ids=keys %SEQ;

	for(my $i=0;$i<=$#ids;$i++)
	{
		for(my $j=0;$j<=$#ids;$j++)
		{
			if($i == $j) {next}
			
			my @S1=split("",$SEQ{$ids[$i]});
			my @S2=split("",$SEQ{$ids[$j]});

			for(my $p=0;$p<=$#S1;$p+=3)
			{
				$n++;
				if($S1[$p] ne $S2[$p]) {$d[0]++}
				if($S1[$p+1] ne $S2[$p+1]) {$d[1]++}
				if($S1[$p+2] ne $S2[$p+2]) {$d[2]++}
			}
		}
	}

	my $div1=$d[0]/$n;
	my $div2=$d[1]/$n;
	my $div3=$d[2]/$n;

	my $ns=$#ids+1;
	my $sres="$i\t$d[0]\t$d[1]\t$d[2]\t$n\t$div1\t$div2\t$div3\t$ns\n";
	$res.=$sres;
}

open my $fd,">$OF";
print $fd $res;
close $fd;

