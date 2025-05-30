use strict;

my $cdsD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/cds';
my $infoD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/listing/list';
my $oD="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/divergence/beforealign";

opendir my $D,$cdsD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	$f=~/^(.*)\.cds\.fa/;
	my $sample=$1;
	if($sample eq "") {next}

	print "$f\n";

	my %SEQ;
        my $id;
	open my $fd,"$cdsD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		if($_=~/>(\w+)/) {$id=$1}
		else {$SEQ{$id}.=$_}
	}
	close $fd;

	my %CNV;
	open my $fd,"$infoD/$sample";
	while(<$fd>)
	{
		$_=~s/\n//;
		if($_=~/\tCNV$/ and $_=~/intact/)
		{
			my @s=split("\t",$_);
			$CNV{$s[1]}.=">$s[0]\n$SEQ{$s[0]}\n";
		}
	}
	close $fd;

	my @gn=keys %CNV;

	foreach my $g (@gn)
	{
		my $geneN=0;
		while($CNV{$g}=~/>/g) {$geneN++}
		
		if($geneN<2) {next}

		my $oF="$oD/$sample.$g.fa";

		open my $fd,">$oF";
		print $fd $CNV{$g};
		close $fd
	}
}



