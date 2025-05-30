use strict;

my $ID='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro';
my $OF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retroSeq';

opendir my $D,$ID;
my @files=readdir($D);
close $D;

my %SEQ;
foreach my $f (@files)
{
	unless($f=~/F/) {next}

	open my $fd,"$ID/$f";
	while(<$fd>)
	{
		if($_=~/NA/) {next}
		$_=~/(\w+)\n/;

		my $seq=$1;
		my $rseq=reverse $seq;
		$rseq=~tr/ATGC/TACG/;
		
		if($SEQ{$seq} eq '' and $SEQ{$rseq} ne '') {$SEQ{$rseq}++}
		elsif($SEQ{$seq} ne '' and $SEQ{$rseq} eq '') {$SEQ{$seq}++}
		elsif($SEQ{$seq} eq '' and $SEQ{$rseq} eq '') {$SEQ{$seq}++}

	}
	close $fd;
}
		
my @seq=keys %SEQ;
foreach my $s (@seq)
{
	print "$s\t$SEQ{$s}\n";

}
		
