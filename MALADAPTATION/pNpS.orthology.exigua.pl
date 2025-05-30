use strict;

my $orthoF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/res/Results_Nov26/Orthogroups/Orthogroups.txt';
my $cnvlistF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $gffF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCA_902829305.4_PGI_SPEXI_v6_genomic.gff.gz';
my $vcfF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/Exigua/exigua.filtered.annotated.SNP.vcf.gz';

my $FO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.exigua';

################################

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

my %GENEL=getgeneList();

my %Chr;
my %Start;
my %End;

open my $fd,"zcat $gffF | ";
while(<$fd>)
{
	unless($_=~/\tCDS\t/) {next}

	$_=~/Name=(\w+)/;
	my $id=$1;
	my @s=split("\t",$_);
	$Chr{$id}=$s[0];
	
	if($Start{$id} eq '') {$Start{$id} = $s[3]}
	elsif($Start{$id} > $s[3]) {$Start{$id} = $s[3]}

	if($End{$id} eq '') {$End{$id} = $s[4]}
	elsif($End{$id} < $s[4]) {$End{$id} = $s[4]}
}

my @ids=keys %Chr;

my @cnv;
my @noncnv;

foreach my $id (@ids)
{
	my $info="$Chr{$id}:$Start{$id}-$End{$id}";
	print "$info\n";
	if($GENEL{$id} eq "CNV") {push @cnv,$info}
	elsif($GENEL{$id} eq "nonCNV") {push @noncnv,$info}
}
close $fd;

my $res="CNV\tN\tS\n";
$res.=SET(\@cnv,"CNV");
$res.=SET(\@noncnv,"NONCNV");
saveF();

sub saveF
{
	open my $fd,">$FO";
	print $fd $res;
	close $fd;
}

sub SET
{
	(my $data,my $tag)=(@_);
	
	my $sres;
	my $i=0;

	my $NN;
	my $SS;
	foreach my $l (@$data)
	{
		$i++;

		my $N=0;
		my $S=0;
		open my $fd,"tabix $vcfF $l |";
		while(<$fd>)
		{
			if($_=~/missense/){$N++}
			if($_=~/synon/) {$S++}
		}
		close $fd;
		$sres.="$tag\t$N\t$S\n";
		$NN+=$N;
		$SS+=$S;

		print "$tag $i $#$data : $NN $SS\n";
	}
	return $sres;
}


sub getgeneList
{
	my %REP;
	open my $fd,$orthoF;
	while(<$fd>)
	{
		$_=~s/\n//;
		$_=~s/^(.*): //;
		my $g=$1;
		my @s=split(" ",$_);

		my $CNV;
		my @exigua;
		foreach my $l (@s)
		{
			$l=~s/\..*$//;

			if($l=~/XP_05/)
			{
				$l=~s/\..*$//;
				if($cnv{$l} eq 'yes') {$CNV='yes'}
			}
			elsif($l=~/XP_03/)
			{
				$l=~s/\..*$//;
				if($cnv{$l} eq 'yes') {$CNV='yes'}
			}
			elsif($l=~/YP_009/)
			{
				$l=~s/\..*$//;
				if($cnv{$l} eq 'yes') {$CNV='yes'}
			}
			elsif($l=~/CA/)
			{
				push @exigua,$l;
			}
		}
		
		if($CNV eq 'yes')
		{
			foreach my $g (@exigua) {$REP{$g}='CNV'}
		}
		else
		{
			foreach my $g (@exigua) {$REP{$g}='nonCNV'}
		}
	}
	close $fd;
	
	return %REP;
}

