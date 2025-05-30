use strict;

my $fI='/home/knam/work/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_genomic.gff.gz';
my $fO='/home/knam/work/sfrugi_WG/RefSeq/uniq_id.txt';

my $preID='';

my %RNAID;
open my $fd,"zcat $fI | ";
while(<$fd>)
{
	unless($_=~/\tmRNA\t/) {next}

	$_=~s/;Dbxref=.*$//;
	$_=~s/^.*\t//;
	$_=~s/;Parent=(.*$)//;
	my $id=$1;
	$_=~s/ID=//;
	$_=~s/\n//g;
	if($id ne $preID)
	{
		$RNAID{$_}=1;
		$preID=$id;
	}
}
close $fd;

my %PTNIDs;

open my $fd,"zcat $fI | ";
while(<$fd>)
{
        unless($_=~/\tCDS\t/) {next}
	$_=~s/\n//;
	$_=~s/protein_id=(.*)$//;
	my $ptnid=$1;
	$ptnid=~s/;.*$//;
	if($ptnid eq '') {next}

	$_=~s/^.*Parent=//;
	$_=~s/;.*//;

	if($RNAID{$_} eq '') {next}

	$PTNIDs{$ptnid}=1;
}

my @is=keys %PTNIDs;
my $r=join("\n",@is);

open my $fd,">$fO";
print $fd $r;
close $fd;
