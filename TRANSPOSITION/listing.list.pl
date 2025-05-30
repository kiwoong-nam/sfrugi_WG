use strict;

my $inD1='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my $inD2='/home/kiwoong/Projects/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/gff';
my $cnvF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $outD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/listing/list';

### miniprot.ID NCBI.ID intact CNV

my %CNV;
open my $fd,$cnvF;
while(<$fd>)
{
	$_=~s/\n//;
	my @s=split("\t",$_);
	$CNV{$s[0]}=$s[1];
}
close $fd;

opendir my $D,$inD1;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	$f=~/^(.*)\.gff/;
	my $sample=$1;
	if($sample eq '') {next}
	
	my $Fall="$inD1/$f";
	my $Fintact="$inD2/$f";
	my $fO="$outD/$f";
	$fO=~s/\.gff//;
		
	my %miniprop2ncbi;
	my %INTACT;
	my %GeneCount;
	open my $fd,$Fall;
	while(<$fd>)
	{
		if($_!~/mRNA/) {next}
		my @info=getinfo($_);
		$INTACT{$info[0]}='stopcodon';
		$miniprop2ncbi{$info[0]}=$info[1];
		$GeneCount{$info[1]}++;
	}
	close $fd;

	open my $fd,$Fintact;
	while(<$fd>)
	{
		if($_!~/mRNA/) {next}
		my @info=getinfo($_);
		$INTACT{$info[0]}='intact';
	}
	close $fd;

	my @ids=keys %miniprop2ncbi;

	my $res;
	foreach my $id (@ids)
	{
		my $gID=$miniprop2ncbi{$id};

		my $cnv;
		if($CNV{$gID} eq 'CNV.GENE')
		{
			if($GeneCount{$gID} > 1) {$cnv='CNV'}
			elsif($GeneCount{$gID} == 1) {$cnv='CNV.single'}
		}
		elsif($CNV{$gID} eq 'nonCNV.GENE' and $INTACT{$id} eq 'intact') { $cnv='nonCNV'}
		if($cnv ne '')
		{
			$res.="$id\t$gID\t$INTACT{$id}\t$cnv\n";
		}
	}
	
	open my $fd,">$fO";
	print $fd $res;
	close $fd;
}


sub getinfo
{
	(my $l)=(@_);
	
	$l=~/ID=([\w|\.]+)/;	
	my $id=$1;

	$l=~/Target=([\w]+)/;	
	my $t=$1;

	return ($id,$t);
}



