use strict;

my $gffF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $vcfF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/FC.filtered.SNV.phased.annotated.vcf.gz';
my $FO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS/counts';

my %CNV;
open my $fd,$cnvF;
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	$CNV{$s[0]}=$s[1];
}
close $fd;

my @cnv_te;
my @cnv_gene;
my @noncnv;

open my $fd,$gffF;
while(<$fd>)
{
	unless($_=~/mRNA/) {next}
	$_=~/Target=(\w+)/;
	my $id=$1;
	my @s=split("\t",$_);

	my $info="$s[0]:$s[3]-$s[4]";
	
	if($CNV{$id} eq "CNV.GENE") {push @cnv_gene,$info}
	elsif($CNV{$id} eq "nonCNV.GENE") {push @noncnv,$info}
}
close $fd;

my $res="CNV\tN\tS\n";

$res.=SET(\@cnv_gene,"CNV.GENE");
$res.=SET(\@noncnv,"NONCNV");

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
	

