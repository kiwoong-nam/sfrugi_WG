use strict;

my $WD="/home/knam/work/sfrugi_WG/TRANSPOSITION/divergence/afteralign";

opendir my $D,$WD;
my @files=readdir($D);
close $D;

my $i=0;
foreach my $f (@files)
{
	unless($f=~/fas$/) {next}
	`/home/knam/save/programs/Gblocks_0.91b/Gblocks $WD/$f -t=c -v=1000000 -p=n`;
	print "$i $#files\n";
	$i++;
}

 
 
 

