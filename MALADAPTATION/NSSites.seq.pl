use strict;

my $outD='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites/seq';
my $inD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/timing/afteralign';

my $F=">frugiperda";
my $L=">litura";
my $E=">exigua";

for(my $i=1;$i<8522;$i++)
{
	print "$i\n";
	my $fI="$inD/g$i.best.fas-gb";
	my $fO="$outD/g$i.codeml.fa";
	
	my %SEQ;
	my $id;
	open my $fd,$fI;
	while(<$fd>)
	{
		$_=~s/\n//;
		$_=~s/ //g;
		if($_=~/>/) {$id=$_;}
		else {$SEQ{$id}.=$_;}
	}
	close $fd;
	
	$SEQ{$F}=~s/...$//;
	$SEQ{$L}=~s/...$//;
	$SEQ{$E}=~s/...$//;

	my $na="$F\n$SEQ{$F}\n$L\n$SEQ{$L}\n$E\n$SEQ{$E}\n";

	open my $fd,">$fO";
	print $fd $na;
	close $fd;
}
