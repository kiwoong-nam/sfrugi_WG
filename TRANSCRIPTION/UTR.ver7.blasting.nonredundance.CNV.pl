use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/CNV';
my $oF='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/nonredundance.CNV.pos';

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

	my @rdata=split("\n",$CHRs{$chromosome});
	my %PC;
	foreach my $d (@rdata) {$PC{$d}=1}
	my @data = sort{$a cmp $b} keys %PC;

	my %INC;
	foreach my $d (@data)
	{
		my @s=split("\t",$d);
		@s=sort {$a <=>$b} @s;

		my $exist='no';
		
		for(my $i=$s[0];$i<=$s[1];$i++)
		{
			if($INC{$i}==1) {$exist='yes'};
			$INC{$i}=1;
		}

		if($exist eq "no")
		{
			my $l=$s[1]-$s[0]+1;
			$res.="$chromosome\t$s[0]\t$s[1]\t$l\n"
		}
	
	}
}

open my $fd,">$oF";
print $fd $res;
close $fd;

