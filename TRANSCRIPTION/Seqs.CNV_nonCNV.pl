use strict;

my $seqD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/seqs';
my $oD="/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/Seqs";

opendir my $D,$seqD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/F/) {next}

	print "$f\n";

	my $oF_CNV="$oD/CNV/$f";
	my $oF_nonCNV="$oD/nonCNV/$f";

	my $CNV;
	my $nonCNV;
	
	my $ic=0;
	my $in=0;
	open my $fd,"$seqD/$f";
	while(<$fd>)
	{
		if($_=~/single/) {next}

		$_=~s/\n//;
		my @s=split("\t",$_);

		$s[5]=~/.{300}$/;

		my $seqS=$&;
		if($seqS eq "") {next}
		my $seq=">$s[1]\n$seqS\n";
	
		if($s[2] eq 'CNV')
		{
			$CNV.=$seq;
		}
		elsif($s[2] eq 'nonCNV')
		{
			$nonCNV.=$seq;
		}
	}
	close $fd;
	
	
	open my $fd,">$oF_CNV";
	print $fd $CNV;
	close $fd;

	open my $fd,">$oF_nonCNV";
	print $fd $nonCNV;
	close $fd;

}



