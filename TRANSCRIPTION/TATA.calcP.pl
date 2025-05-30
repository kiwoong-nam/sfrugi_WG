use strict;

my $IF='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/mean';
my $GD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/seq/assembly';
my $FO='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/TATA/calcP';

my $B=1000;
my $le=300;

open my $fd,$IF;
my @data=<$fd>;
close $fd;

my $res=shift @data;
$res=~s/\n$/\tp\tb.m\tb.l\tb.u\n/;

foreach my $l (@data)
{
	$l=~s/\n//;
	my @s=split("\t",$l);

	my $seF="$GD/$s[0].fa.gz";

	my $SEQ;
	open my $fd,"zcat $seF | ";
	while(<$fd>)
	{
		unless($_=~/>/) {$SEQ.=$_}	
	}
	close $fd;
	
	$SEQ=~s/\s//g;

	my $pval=0;
	my @Bs;
	for(my $b=0;$b<=$B;$b++)
	{
		my $byes;
		my $bno;

		for(my $i=0;$i<$s[2];$i++)
		{
			my $p=int rand (length $SEQ);
			my $sseq=substr($SEQ,$p,$le);

			if($sseq=~/TATA[A|T]A[A|T]/) {$byes++}
			else {$bno++}
		}
		my $bp=$byes/($byes+$bno);
		if($bp>=$s[3]) {$pval++}
		push @Bs,$bp;
	}
	$pval=$pval/$B;
	
	@Bs=sort {$a <=> $b} @Bs;
	my $bm;
	foreach my $b (@Bs) {$bm+=$b}
	$bm=$bm/$B;
	
	$l.="\t$pval\t$bm\t$Bs[25]\t$Bs[975]\n";
	print $l;
	$res.=$l;
}

open my $fd,">$FO";
print $fd $res;
close $fd;
