use strict;

my $fileIn='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/counts/geneID_copies';
my $fileOut='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV/list.txt';

my $res="#ID FC01,FC03,FC_100,FC_102,FC_104,FC_106,FC33,FC37,FC54,FC71,FC76,FC78,FC81,FC_84,FC_88,FC_90,FC_95,FC_98,FC02,FC04,FC_101,FC_103,FC_105,FC32,FC35,FC52,FC55,FC72,FC77,FC79,FC82,FC_85,FC_89,FC_92,FC_97,FC_99\tCNV\n";

open my $fd,$fileIn;
while(<$fd>)
{
	if($_=~/#/) {next}
	
	$_=~s/\n//;
	my @s=split("\t",$_);
	my $id=shift @s;
	#	print "$id\n";
	my @NS=split(',',$s[0]);
	shift @NS;

	my %CT;
	foreach my $is (@NS)
	{
		if($is > 0)
		{
			$CT{$is}++;
		}
	}
	my @als=sort {$a <=> $b} keys %CT;

	my @AFSF;
	foreach my $af (@als)
	{
		push @AFSF,$CT{$af};
	#		print "$af $CT{$af}\n";
	}
	my $SF=join(',',@AFSF);

	my @AFSF=sort {$b <=> $a} @AFSF;

	shift @AFSF;
	my $secondallele=shift @AFSF;

	my $CNV='no';
	if($secondallele > 4) {$CNV='yes'}

	my $nm=0;
	while($_=~/0,/g) {$nm++}

	if($nm<(36-23)){print "$_ : $nm\n";}
	if($nm<(36-23)) {$res.="$_\t$CNV\n"} #### new add
}
close $fd;

open my $fd,">$fileOut";
print $fd $res;
close $fd;


