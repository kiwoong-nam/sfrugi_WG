use strict;

my $DI="/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/counts";
my $fO1="/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/mean";
my $fO2="/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/contingency";

my $B=1000;

opendir my $D,$DI;
my @files=readdir($D);
close $D;

my $res1="sample\tCNV\tm\tl\tu\n";
my $res2="sample\tcnv.N\tcnv.S\tnoncnv.N\tnoncnv.S\n";

foreach my $f (@files)
{
	if($f=~/fa/) {next}
	unless($f=~/^(F\w+)/) {next}
	my $sample=$1;
	if($sample eq "FC_98") {next}
	print "$sample\n";

	my @data;
	open my $fd,"$DI/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		push @data,$_;
	}
	close $fd;

	my @bg=cat(@data);
	
	my @B_CNV;
	my @B_nCNV;
	
	for(my $b=0;$b<$B;$b++)
	{
		my @bdata;
		for(my $i=0;$i<=$#data;$i++)
		{
			push @bdata,$data[int rand ($#data+1)];
		}
		my @bt=cat(@bdata);
		push @B_CNV,$bt[0];
		push @B_nCNV,$bt[1];
	}

	@B_CNV=sort {$a <=> $b} @B_CNV;
	@B_nCNV=sort {$a <=> $b} @B_nCNV;

	$res1.="$sample\tCNV\t$bg[0]\t$B_CNV[25]\t$B_CNV[975]\n";
	$res1.="$sample\tnonCNV\t$bg[1]\t$B_nCNV[25]\t$B_nCNV[975]\n";

	print "@bg\n";
	shift @bg;
	shift @bg;
	$res2.="$sample\t".join("\t",@bg)."\n";


	open my $fd,">$fO1";
	print $fd $res1;
	close $fd;

	open my $fd,">$fO2";
	print $fd $res2;
	close $fd;
}


sub cat
{
	(my @d)=(@_);
	
	my $cnv_N;
	my $cnv_S;

	my $ncnv_N;
	my $ncnv_S;
	
	foreach my $v (@d)
	{
		my @s=split("\t",$v);
		if($s[0] eq 'CNV.GENE')
		{
			$cnv_N+=$s[1];
			$cnv_S+=$s[2];
		}
		elsif($s[0] eq 'NONCNV')
		{
			$ncnv_N+=$s[1];
			$ncnv_S+=$s[2];
		}
	}
	
	my $cnvR=$cnv_N/$cnv_S;
	my $ncnvR=$ncnv_N/$ncnv_S;
	
	return ($cnvR,$ncnvR,$cnv_N,$cnv_S,$ncnv_N,$ncnv_S);

}
