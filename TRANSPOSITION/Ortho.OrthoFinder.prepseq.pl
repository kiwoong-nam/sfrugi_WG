use strict;

my $WD='/home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder';

my $fIe="$WD/rawdata/GCA_902829305.4_PGI_SPEXI_v6_protein.faa.gz";
my $fIl="$WD/rawdata/GCF_002706865.2_ASM270686v3_protein.faa.gz";

my $OD="$WD/input";
my $idFe="$OD/exigua.list";
my $idFl="$OD/litura.list";

ets($fIe,$idFe,'exigua');
ets($fIl,$idFl,'litura');

`cp /home/knam/work/sfrugi_WG/RefSeq/uniq_gene.fa /home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input/seq/frugiperda.fa`;

sub ets
{
	(my $fI,my $idF,my $tag)=(@_);

	my $fO="$OD/seq/$tag.fa";
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
}
