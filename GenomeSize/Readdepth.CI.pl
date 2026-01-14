use strict;

my $RD='/home/kiwoong/Projects/sfrugi_WG/GenomeSize/Readdepth';
my $fO='/home/kiwoong/Projects/sfrugi_WG/GenomeSize/Readdepth/CI.txt';

my $B=1000;

opendir my $D,$RD;
my @files=readdir($D);
close $D;

my $res="sample\tstats\tm\tu\tl\n";

foreach my $f (@files)
{
	unless($f=~/^(.*).bed.regions.bed.gz$/) {next}
	my $sample=$1;
	print "$sample\n";
	my @data;
	open my $fd,"zcat $RD/$f | ";
	while(<$fd>)
	{
		chomp $_;
		$_=~s/^HiC_scaffold_//;
		my @s=split("\t",$_);
		if($s[0]>29) {next}
		push @data,"$s[0]\t$s[3]";
	}
	close $fd;

	my @bg=ctss(@data);

	my @bA;
	my @bZ;
	my @bR;
	for(my $b=0;$b<$B;$b++)
	{
		my @bdata;
		for(my $i=0;$i<=$#data;$i++) {push @bdata,$data[int rand $#data]}
		
		my @bts=ctss(@bdata);
		push @bA,$bts[0];
		push @bZ,$bts[1];
		push @bR,$bts[2];
	}

	@bA=sort{$a <=> $b} @bA;
	@bZ=sort{$a <=> $b} @bZ;
	@bR=sort{$a <=> $b} @bR;

	$res.="$sample\tAutosome\t$bg[0]\t$bA[975]\t$bA[25]\n";
	$res.="$sample\tZ\t$bg[1]\t$bZ[975]\t$bZ[25]\n";
	$res.="$sample\tRatio\t$bg[2]\t$bR[975]\t$bR[25]\n";
}

open my $fd,">$fO";
print $fd $res;
close $fd;

sub ctss
{
	(my @v)=(@_);
	
	my $SZ=0;
	my $nZ=0;
	my $SA=0;
	my $nA=0;

	foreach my $val (@v)
	{
		my @sn=split("\t",$val);
		if($sn[0]==29)
		{
			$nZ++;
			$SZ+=$sn[1];
		}
		else
		{
			$nA++;
			$SA+=$sn[1];
		}
	}

	my $rdA=$SA/$nA;
	my $rdZ=$SZ/$nZ;
	my $R=$rdZ/$rdA;
	return ($rdA,$rdZ,$R);
}

