use strict;

my $oD='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/DAGChainer';
my $cateF='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/BUSCO_genes';
my $inD='/home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/input';

my %incl;
open my $fd,$cateF;
while(<$fd>)
{
	$_=~s/\n//g;
	$incl{$_}=1;
}
close $fd;

exect('litura');
exect('exigua');

sub exect
{
	(my $sp)=(@_);
	
	my $outF="$oD/pairwise_blast.aligncoords.BUSCO.$sp";
	my $inF="$inD/pairwise_blast.$sp.aligncoords";
	print "ls $inF\n";
	my $res;
	open my $fd,$inF;
	while(<$fd>)
	{
		my @s=split("\t",$_);

		my $tet=$incl{$s[1]}+$incl{$s[5]};
		if($tet==0) {next}
		if($_=~/#/) {next}
		$res.=$_;
	}
	close $fd;
	
	open my $fd,">$outF";
	print $fd $res;
	close $fd;

}

