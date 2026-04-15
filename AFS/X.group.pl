use strict;

## genes with multitones
## genes only with singletons
## for each of CNV and non-CNV

## No. of loci per gene

my $iDCNV='/home/knam/work/sfrugi_WG/AFS/X/count';
my $iDnonCNV='/home/knam/work/sfrugi_WG/AFS/X/Ucount';
my $oF='/home/knam/work/sfrugi_WG/AFS/X/group.txt';

my $res;
exta($iDCNV,'CNV');
exta($iDnonCNV,'nonCNV');

open my $fd,">$oF";
print $fd $res;
close $fd;

sub exta
{
	(my $iD,my $tag)=(@_);

	opendir my $D,$iD;
	while(readdir($D))
	{
		my $fN=$_;
		unless($fN=~/X/) {next}
		my $multi="no";
		my $ng=0;
		open my $fd,"$iD/$fN";
		while(<$fd>)
		{
			$_=~s/\n//g;
			$_=~/(\d+)$/;
			if($1>1) {$multi='yes';}
			$ng++;
		}
		close $fd;
		$res.="$tag\t$fN\t$ng\t$multi\n";
	}
	close $D;

}













