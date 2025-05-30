use strict;

my $DI="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Transducing/distTEGene";
my $fO1="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Transducing/mean";
my $fO2="/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Transducing/contingency";

my $cate=100;
my $B=1000;

opendir my $D,$DI;
my @files=readdir($D);
close $D;

my $res1="sample\tCNV\tm\tl\tu\n";
my $res2="sample\tcnv.C\tcnv.NC\tnoncnv.C\tnoncnv.NC\n";

foreach my $f (@files)
{
	if($f=~/fa/) {next}
	unless($f=~/^(F\w+)/) {next}
	my $sample=$1;
	print "$sample\n";

	my @data;
	open my $fd,"$DI/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		push @data,"$s[0]\t$s[2]";
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

	shift @bg;
	shift @bg;
	
	$res2.="$sample\t".join("\t",@bg)."\n";
}

open my $fd,">$fO1";
print $fd $res1;
close $fd;

open my $fd,">$fO2";
print $fd $res2;
close $fd;


sub cat
{
	(my @d)=(@_);
	
	my $cnv_c;
	my $ncnv_c;
	my $cnv_nc;
	my $ncnv_nc;
	
	foreach my $v (@d)
	{
		my @s=split("\t",$v);
		if($s[0] eq 'CNV')
		{
			if($s[1]<$cate) {$cnv_c++}
			else {$cnv_nc++}
		}
		elsif($s[0] eq 'nonCNV')
		{
			if($s[1]<$cate) {$ncnv_c++}
			else {$ncnv_nc++}
		}
	}
	
	my $cnvP=$cnv_c/($cnv_c+$cnv_nc);
	my $ncnvP=$ncnv_c/($ncnv_c+$ncnv_nc);
	
	return ($cnvP,$ncnvP,$cnv_c,$cnv_nc,$ncnv_c,$ncnv_nc);

}
