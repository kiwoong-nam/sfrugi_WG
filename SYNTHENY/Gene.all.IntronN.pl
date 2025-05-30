use strict;

my $orthoF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/res/Results_Nov26/Orthogroups/Orthogroups.txt';
my $fI_faw='/home/kiwoong/Projects/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_genomic.gff.gz';
my $fI_exigua='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCA_902829305.4_PGI_SPEXI_v6_genomic.gff.gz';
my $fI_litura=' /home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCF_002706865.2_ASM270686v3_genomic.gff.gz';

my $cnvlistF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';

my $oF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Gene/all/intronN';

#############################

my %cnv;
open my $fd,$cnvlistF;
while(<$fd>)
{
	$_=~s/\n//;
        my @s=split("\t",$_);
	if($s[1] eq 'nonCNV.GENE') {$cnv{$s[0]}='no'}
	elsif($s[1] eq 'CNV.GENE') {$cnv{$s[0]}='yes'}	
}
close $fd;

my %faw=getI($fI_faw);
my %exigua=getI($fI_exigua);
my %litura=getI($fI_litura);

my $res;
open my $fd,$orthoF;
while(<$fd>)
{
	$_=~s/\n//;
	$_=~s/^(.*): //;
	my $g=$1;
	my @s=split(" ",$_);
	my $FAW;
	my $LITURA;
	my $EXIGUA;
	my $CNV;
	
	foreach my $l (@s)
	{
		$l=~s/\..*$//;
		if($l=~/XP_02/)
		{
			if($litura{$l} ne '') {$LITURA.="$litura{$l},"}
		}
		elsif($l=~/YP_008/)
		{
			if($litura{$l} ne '') {$LITURA.="$litura{$l},"}
		}
		elsif($l=~/CA/)
		{
			if($exigua{$l} ne '') {$EXIGUA.="$exigua{$l},"}
		}
		elsif($l=~/XP_05/)
		{
			$l=~s/\..*$//;
			if($faw{$l} ne '')
			{
				$FAW.="$faw{$l},";
				$CNV.="$cnv{$l},";
			}
		}
		elsif($l=~/XP_03/)
		{
			$l=~s/\..*$//;
			if($faw{$l} ne '')
			{
				$FAW.="$faw{$l},";
				$CNV.="$cnv{$l},";
			}
		}
		elsif($l=~/YP_009/)
		{
			$l=~s/\..*$//;
			if($faw{$l} ne '')
			{
				$FAW.="$faw{$l},";
				$CNV.="$cnv{$l},";
			}
		}
		else{print "something is wrong"}
	}

	if($CNV eq "") {next}
	if($FAW eq '' or $LITURA eq '' or $EXIGUA eq '') {next}
	my $sl="$g\t$CNV\t$FAW\t$LITURA\t$EXIGUA\n";
	print $sl;
	$res.=$sl;
}

open my $fd,">$oF";
print $fd $res;
close $fd;

	
########################
sub getI
{
	(my $fI)=(@_);
        
	my %p;
	open my $fd,"zcat $fI | ";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		unless($s[2] eq 'CDS') {next}		

		$_=~/Name=(\w+)/;
		$p{$1}++;
	}
	close $fd;

	return %p;
}


