use strict;

my $orthoF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/res/Results_Nov26/Orthogroups/Orthogroups.txt';
my $cnvlistF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $gffF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $vcfF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/FC.filtered.SNV.phased.annotated.vcf.gz';

my $FO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/orthology.FAW';

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
my @cnvp;
my @noncnvp;
my @noncnv;

open my $fd,$gffF;
while(<$fd>)
{
	unless($_=~/mRNA/) {next}
	$_=~/Target=(\w+)/;
	my $id=$1;
	my @s=split("\t",$_);

	my $info="$s[0]:$s[3]-$s[4]";

	if($GENEL{$id} eq "CNV.P") {push @cnvp,$info}
	elsif($GENEL{$id} eq "nonCNV.P") {push @noncnvp,$info}
	elsif($GENEL{$id} eq "nonCNV") {push @noncnv,$info}
}
close $fd;

my $res="CNV\tN\tS\n";

$res.=SET(\@cnvp,"CNVOrtho.CNV");
$res.=SET(\@noncnvp,"CNVOrtho.nonCNV");
$res.=SET(\@noncnv,"nonCNVOrtho");

print $res;

saveF();

sub SET
{
	(my $data,my $tag)=(@_);
	
	my $sres;
	my $i=0;

	foreach my $l (@$data)
	{
		$i++;
		print "$tag $i $#$data\n";

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
	}
	return $sres;
}

sub saveF
{
	open my $fd,">$FO";
	print $fd $res;
	close $fd;
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
		my $nonCNV;
		my @FAW;
		foreach my $l (@s)
		{
			$l=~s/\..*$//;

			if($l=~/XP_05/)
			{
				$l=~s/\..*$//;
				push @FAW,$l;
				if($cnv{$l} eq 'yes') {$CNV='yes'}
				if($cnv{$l} eq 'no') {$nonCNV='yes'}
			}
			elsif($l=~/XP_03/)
			{
				$l=~s/\..*$//;
				if($cnv{$l} eq 'yes') {$CNV='yes'}
				if($cnv{$l} eq 'no') {$nonCNV='yes'}
				push @FAW,$l;
			}
			elsif($l=~/YP_009/)
			{
				$l=~s/\..*$//;
				if($cnv{$l} eq 'yes') {$CNV='yes'}
				if($cnv{$l} eq 'no') {$nonCNV='yes'}
				push @FAW,$l;
			}
		}
		
		
		if($CNV eq 'yes' and $nonCNV eq 'yes')
		{
			if($#FAW >0)
			{
				foreach my $g (@FAW)
				{
					if($cnv{$g} eq 'yes') {$REP{$g}='CNV.P'}
					if($cnv{$g} eq 'no') {$REP{$g}='nonCNV.P'}
				}	
			}
		}
		if($CNV ne 'yes' and $nonCNV eq 'yes')
		{
			foreach my $g (@FAW)
			{
				$REP{$g}='nonCNV';
			}	
	
		}
	}
	
	return %REP;
}

