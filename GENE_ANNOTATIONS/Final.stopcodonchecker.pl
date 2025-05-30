use strict;

my $inD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/cds';

opendir my $D,$inD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/fa/) {next}
	unless($f=~/^F/) {next}

	print "$f\n";
	my $seq;
	my $nm;
	open my $fd,"$inD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		if($_=~/>/)
		{
			checker($seq,"$f $nm");
			undef $seq;
			$nm=$_;
			next
		}
		else
		{
			$seq.=$_;
		}
	}
	close $fd;

	checker($seq,"$f $nm");
}

sub checker
{
	(my $s,my $ix)=(@_);

	$s=~s/...$//;
		
	for(my $i=0;$i<(length $s);$i+=3)
	{
		my $codon=substr($s,$i,3);
		if($codon eq 'TAG' or $codon eq 'TAA' or $codon eq 'TGA')
		{
			print "stop codons! $ix, position $i\n";
		}
		else
		{
			#			print "non stop codons!\n";
		}
	}	

}


