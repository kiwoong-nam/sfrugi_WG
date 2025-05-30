use strict;

my $inD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/filter_pseudo/cds';
my $outF='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/filter_pseudo/stopcodons.txt';

opendir my $D,$inD;
my @files=readdir($D);
close $D;

my $res;
foreach my $f (@files)
{
	unless($f=~/fa/) {next}
	unless($f=~/^F/) {next}
	my $seq;
	my $nm;
	open my $fd,"$inD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		if($_=~/>/)
		{
			checker($seq,"$f\t$nm");
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

	checker($seq,"$f\t$nm");
}
$res=~s/>//g;
$res=~s/\.cds\.fa//g;

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


