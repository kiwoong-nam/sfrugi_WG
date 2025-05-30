use strict;

my $gffF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $cnvD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/dupl';
my $vcfF='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/FC.filtered.SNV.phased.annotated.vcf.gz';
my $DO='/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/pNpS_indi/counts';

opendir my $D,$cnvD;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f =~/dupl/) {next}

	my $pid = fork();
	if($pid < 0)
	{
		print "Failed to fork process... Exiting";
		exit(-1);
	}
	elsif ($pid ==0)
	{	
		$f=~/^(\w+).dupl/;
		my $sample=$1;
		my $FO="$DO/$sample";

		my %CNV;

		open my $fd,"$cnvD/$f";
		while(<$fd>)
		{
			$_=~s/\n//;
			my @s=split("\t",$_);
			$CNV{$s[0]}='CNV';
		}
		close $fd;

		my @cnv;
		my @noncnv;

		open my $fd,$gffF;
		while(<$fd>)
		{
			unless($_=~/mRNA/) {next}
			$_=~/Target=(\w+)/;
			my $id=$1;
			my @s=split("\t",$_);

			my $info="$s[0]:$s[3]-$s[4]";
			
			if($CNV{$id} eq "CNV") {push @cnv,$info}
			else {push @noncnv,$info}
		}
		close $fd;


		my $res="CNV\tN\tS\n";
		$res.=SET(\@cnv,"CNV.GENE",$sample);
		$res.=SET(\@noncnv,"NONCNV",$sample);

		open my $fd,">$FO";
		print $fd $res;
		close $fd;	
		exit(1);
	}
	else {}
}

my $kid;
do {
  $kid = waitpid -1, 0;
} while ($kid > 0);


######

sub SET
{
	(my $data,my $tag,my $s)=(@_);
	
	my $sres;
	my $i=0;

	my $rnk=int rand 10000000;
	foreach my $l (@$data)
	{
		$i++;
		print "$s $i $#$data\n";

		my $vcf_ns;
		my $vcf_s;
		
		open my $fd,"tabix -h $vcfF $l | ";
		while(<$fd>)
		{
			if($_=~/#/)
			{
				$vcf_ns.=$_;
				$vcf_s.=$_;
			}
			elsif($_=~/missense/) {$vcf_ns.=$_}
			elsif($_=~/synon/) {$vcf_s.=$_}
		}
		close $fd;
		
		open my $fd,">$DO/ns.$rnk.vcf";
		print $fd $vcf_ns;
		close $fd;
		
		open my $fd,">$DO/s.$rnk.vcf";
		print $fd $vcf_s;
		close $fd;
	
		my $N=0;
		open my $fd,"vcftools --vcf $DO/ns.$rnk.vcf --indv $s --recode -c | ";
		while(<$fd>)
		{
			if($_=~/0\/1/ or $_=~/1\/1/ or $_=~/0\|1/ or $_=~/1\|1/) {$N++}
		}
		close $fd;
			
		my $S=0;
		open my $fd,"vcftools --vcf $DO/s.$rnk.vcf --indv $s --recode -c | ";
		while(<$fd>)
		{
			if($_=~/0\/1/ or $_=~/1\/1/ or $_=~/0\|1/ or $_=~/1\|1/) {$S++}
		}
		close $fd;

		`rm $DO/ns.$rnk.vcf`;
		`rm $DO/s.$rnk.vcf`;

		$sres.="$tag\t$N\t$S\n";
	}
	return $sres;
}
	
