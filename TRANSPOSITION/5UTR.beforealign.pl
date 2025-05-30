use strict;

my $seqD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/seqs';
my $oD="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/5UTR/beforealign";

opendir my $D,$seqD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/F/) {next}
#	print "$f\n";
	my %CNV;
	open my $fd,"$seqD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		if($s[2] ne 'CNV') {next}
		$s[5]=~/.{300}$/;
		my $seqS=$&;
		my $seq=">$s[1]|$s[3]\n$seqS\n";
		$CNV{$s[0]}.=$seq;
	}
	close $fd;

	my @gn=keys %CNV;

	foreach my $g (@gn)
	{
		my $geneN=0;
		while($CNV{$g}=~/>/g) {$geneN++}
		
		if($geneN<2) {next}
		if(length $CNV{$g} <200) {next}

		my $oF="$oD/$f.$g.fa";

		open my $fd,">$oF";
		print $fd $CNV{$g};
		close $fd;

	}
}



