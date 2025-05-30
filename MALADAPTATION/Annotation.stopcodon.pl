use strict;

my $WD='/home/knam/work/sfrugi_WG/MALADAPTATION/Annotation';
my $inF="$WD/sfC.cds.fa";
my $outF="$WD/stopcodons.txt";

my $res;
my $seq;
open my $fd,$inF;
while(<$fd>)
{
	$_=~s/\n//;
	if($_=~/>/)
	{
		checker($seq,$_);
		undef $seq;
		next
	}
	else
	{
		$seq.=$_;
	}
}
close $fd;
checker($seq,$_);

$res=~s/>//g;

open my $fd,">$outF";
print $fd $res;
close $fd;

sub checker
{
	(my $s,my $ix)=(@_);

	$s=~s/...$//;
		
	for(my $i=0;$i<(length $s);$i+=3)
	{
		my $codon=substr($s,$i,3);
		if($codon eq 'TAG' or $codon eq 'TAA' or $codon eq 'TGA')
		{
			$res.="$ix\n";
			print "stop codons! $ix, position $i\n";
		}
		else
		{
			#			print "non stop codons!\n";
		}
	}	

}


