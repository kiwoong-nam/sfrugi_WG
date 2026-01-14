use strict;

my $gffD='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my @sample=qw(FC01  FC03  FC_100  FC_102  FC_104  FC_106  FC33  FC37  FC54  FC71  FC76  FC78  FC81  FC_84  FC_88  FC_90  FC_95  FC_98 FC02  FC04  FC_101  FC_103  FC_105  FC32  FC35  FC52  FC55  FC72  FC77  FC79  FC82  FC_85  FC_89  FC_92  FC_97  FC_99);
my $cnvGF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/CNV.txt';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $ragD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/ragtag';
my $outD='/home/kiwoong/Projects/sfrugi_WG/Quanti/Distal';

my %CNV;
open my $fd,$cnvF;
while(<$fd>)
{
	$_=~s/\n//;
        my @s=split("\t",$_);
	if($s[1] eq 'CNV.GENE') {$CNV{$s[0]}=1}
}
close $fd;

for(my $i=0;$i<=$#sample;$i++)
{
	my $gffF="$gffD/$sample[$i].gff";
	my $ragF="$ragD/$sample[$i].ragtag.scaffold.agp";
	my $output="$outD/$sample[$i]";
	
	my %ctg2chr;

	open my $fd,$ragF;
	while(<$fd>)
	{
		my @s=split("\t",$_);
		if($s[4] eq "W" and $_=~/HiC/)
		{
			$s[0]=~s/HiC_scaffold_//g;
			$s[0]=~s/_RagTag//g;
			$ctg2chr{$s[5]}=$s[0];
		}
	}
	close $fd;

	my %LIST;
	open my $fd,$cnvGF;
	while(<$fd>)
	{
	        my @s=split("\t",$_);
		unless($CNV{$s[0]}==1) {next}		
		my @sl=split(",",$s[1]);
		if($sl[$i] > 1) {$LIST{$s[0]}=1}
	}
	close $fd;

	my %genes;
	open my $fd,$gffF;
	while(<$fd>)
	{
		$_=~/Target=(\w+)/;
		my $id=$1;
		unless($LIST{$id}==1) {next}
		unless($_=~/mRNA/) {next}

		$_=~/ID=(\w+)/;
		my $gID=$1;
		my @single=split("\t",$_);
		my $chrN=$ctg2chr{$single[0]};
		$genes{$id}.="$chrN\t$gID\n"	
	}
	close $fd;
	
	my @k=keys %genes;
	
	my $res;
	foreach my $g (@k)
	{
		my @copies=split("\n",$genes{$g});
		
		my %FREQ;
		foreach my $cp (@copies)
		{
			$cp=~/^\d+/;
			my $n=$&;
			$FREQ{$n}++;
		}
		my @chrs=keys %FREQ;
		my $mx=-1;
		my $mx_chn;
		foreach my $ch (@chrs)
		{
			if($FREQ{$ch} > $mx)
			{
				$mx=$FREQ{$ch};
				$mx_chn=$ch;		
			}
		}

		foreach my $cp (@copies)
		{
			$cp=~/^(\d+)\t(\w+)$/;
			my $chrN=$1;
			my $id=$2;

			if($id eq '') {next}
			if($chrN==$mx_chn) {$res.="$id\tintra\n"}
			else {$res.="$id\tinter\n"}
		}
	}
	
	open my $fd,">$output";
	print $fd $res;
	close $fd;      

}



