use strict;

my $fI='/home/knam/work/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_protein.faa.gz';
my $idF='/home/knam/work/sfrugi_WG/RefSeq/uniq_id.txt';
my $fO='/home/knam/work/sfrugi_WG/RefSeq/uniq_gene.fa';

my %SEQs;
my $id;
open my $fd,"zcat $fI | ";
while(<$fd>)
{
	$_=~s/\n//;
	if($_=~/>/)
	{
		$_=~s/ .*//;
		$_=~s/>//;
		$id=$_;
	}
	else {$SEQs{$id}.=$_}

}

my $r;
open my $fd,$idF;
while(<$fd>)
{
	$_=~s/\n//;
	$r.=">$_\n$SEQs{$_}\n";
}

open my $fd,">$fO";
print $fd $r;
close $fd;
