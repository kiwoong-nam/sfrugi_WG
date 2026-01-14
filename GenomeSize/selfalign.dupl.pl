use strict;

my $RD='/home/kiwoong/Projects/sfrugi_WG/GenomeSize/selfalign/paf';
my $oF="/home/kiwoong/Projects/sfrugi_WG/GenomeSize/selfalign/dupl.txt";
my $iden=0.98;

opendir my $D,$RD;
my @files = grep { /\.paf\.gz$/ } readdir($D);
close $D;

my $res;

GES(100000);

open my $fd,">$oF";
print $fd $res;
close $fd;

sub GES
{
	(my $SL)=(@_);

	foreach my $file (@files)
	{
	 	$file =~ /^(.*)\.paf\.gz$/;
	  	my $sample=$1;

		open my $fd,"zcat $RD/$file | ";
		while(<$fd>)
		{
			my @s=split("\t",$_);
			if ($s[0] eq $s[5] and $s[1] eq $s[6]) {next}
			if($s[10] < $SL) {next}

			my $identity=$s[9]/$s[10];
			if($identity < $iden) {next}
			$res.="$SL:$sample $_";
		}
		close $fd;
	}
}

