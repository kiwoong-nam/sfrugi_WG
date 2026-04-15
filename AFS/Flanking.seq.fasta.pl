use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/AFS/Flanking/seq/tbl';
my $OD="/home/kiwoong/Projects/sfrugi_WG/AFS/Flanking/seq/fasta";

opendir my $D,$inD;
my @files=readdir($D);
close $D;

my @samples;
foreach my $f (@files)
{
	if($f=~/F/) {push @samples,$f}
}

foreach my $sample (@samples)
{
	print "$sample\n";

	my $of="$OD/$sample.flanking.fa";

	my $seqs;
	open my $fd,"$inD/$sample";
	while(<$fd>)
	{
		if($_=~/nonCNV/) {next}		

		$_=~s/\n//;
		my @s=split("\t",$_);
		$seqs.=">$s[0].$s[1].1\n$s[5]\n>$s[0].$s[1].2\n$s[6]\n";
	}
	close $fd;
	
	open my $fd,">$of";
	print $fd $seqs;
	close $fd;
}

