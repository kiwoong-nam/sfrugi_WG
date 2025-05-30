use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/nonCNV';
my $oF='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/nonredundance.nonCNV.pos';

opendir my $D,$inD;
my @files=readdir($D);
close $D;

print "reading files:";
my %CHRs;
foreach my $f (@files)
{
	unless($f=~/gz/) {next}
	print "$f ";
	open my $fd,"zcat $inD/$f | ";
	while(<$fd>)
	{
		$_=~s/HiC_scaffold_//;
		$_=~s/\n//;
		my @s=split(" ",$_);

		if($s[5] <90) {next} # if identity less than 90%
		if($s[4] <270) {next} # if coverage less than 90%

		$CHRs{$s[1]}.="$s[2]\t$s[3]\n";
	}
	close $fd;
}

print "\n\n\ncounting";
my $res="chromosome\tstart\tend\tlen\n";

for(my $chromosome=1;$chromosome<30;$chromosome++)
{
	print "chr$chromosome\n";

	my @data=split("\n",$CHRs{$chromosome});

	my %INC;
	
	foreach my $d (@data)
	{
		my @s=split("\t",$d);
		@s=sort {$a <=>$b} @s;
		my $mid=int(($s[0]+$s[1])/2);
		my $l=$s[1]-$s[0]+1;
		if($INC{$mid} eq "") {$res.="$chromosome\t$s[0]\t$s[1]\t$l\n"}
	
		for(my $i=$s[0];$i<=$s[1];$i++)
		{
			$INC{$i}=1;
		}
	}
}

open my $fd,">$oF";
print $fd $res;
close $fd;

