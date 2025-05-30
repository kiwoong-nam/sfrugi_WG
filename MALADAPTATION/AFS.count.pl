use strict;

my $gffF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $vcfF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/FC.filtered.SNV.phased.annotated.vcf.gz';
my $FO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/AFS/counts';

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
$res.=SETA(\@cnv_gene,"CNV");
saveF();

$res.=SETA(\@noncnv,"NONCNV");
saveF();

sub SETA
{
        (my $data,my $tag)=(@_);
        
        my $sres;
        my $ij=0;

	N:foreach my $l (@$data)
        {
		$ij++;

		print "$tag $ij $#$data\n";
		my @N;
		my @S;

		for(my $i=0;$i<35;$i++)
		{
			push @N,0;
			push @S,0;
		}

		open my $fd,"tabix $vcfF $l |";
		L:while(<$fd>)
		{
			$_=~s/\n//;
			my @s=split("\t",$_);

			my $AF=0;
			for(my $i=9;$i<=$#s;$i++)
			{
				$s[$i]=~s/^(\d)[\|\/](\d)//;
				if($1>1 or $2 > 1) {next L}
				if($1 eq '') {next L}
				$AF+=($1+$2);
			}
			if($AF>35) {$AF=70-$AF}

			if($_=~/missense/){$N[$AF]++}
			if($_=~/synon/) {$S[$AF]++}
		}
		close $fd;

		shift @N;
		shift @S;

		my $N=join(",",@N);
		my $S=join(",",@S);

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
	

