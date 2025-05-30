use strict;

my $fIE='/home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCA_902829305.4_PGI_SPEXI_v6_genomic.gff.gz';
my $fIL='/home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/rawdata/GCF_002706865.2_ASM270686v3_genomic.gff.gz';
my $DO='/home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input';

exi($fIE,'exigua');
exi($fIL,'litura');

sub exi
{
	(my $fI,my $tag)=(@_);

	my $fO="$DO/$tag.list";

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
}
