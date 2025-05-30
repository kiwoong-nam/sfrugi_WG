use strict;

my $ID='/home/knam/work/sfrugi_WG/POSITION/TE/repeatmasker';
my $OD='/home/knam/work/sfrugi_WG/POSITION/TE/abundance/index';

opendir my $D,$ID;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/^(.*).gz/) {next}
	
	my $fn=$1;
	print "$fn\n";
	`zcat $ID/$f > $OD/$fn`;
	`/home/knam/save/programs/samtools-1.9/samtools faidx $OD/$fn`;

}
`rm $OD/*fa`;

