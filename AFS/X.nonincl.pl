use strict;
use List::Util qw(max);

my $ID='/home/knam/work/sfrugi_WG/AFS/Flanking/minimap/mapping';
my $oF="/home/knam/work/sfrugi_WG/AFS/X/nonincl.txt";

my $maxdist=100;
my $mincoverage=80000;

my %P;
my %D;

opendir my $D,$ID;
while(readdir($D))
{
	unless($_=~/F\w+/) {next}
	my $sample=$&;
	
	my %POS1;
	my %POS2;

	open my $fd,"$ID/$_";
	while(<$fd>)
	{
		my @s=split("\t",$_);

	        my @gn=split('\.',$s[0]);

	        my @ps=sort{$a <=> $b} ($s[7],$s[8]);
		if($s[8]-$s[7] > $mincoverage) {next} 
		my $pos="$s[5]\t$ps[0]\t$ps[1]\n";

		if($gn[2] ==1) {$POS1{"$gn[0]\t$gn[1]"}.=$pos}
		elsif($gn[2] ==2) {$POS2{"$gn[0]\t$gn[1]"}.=$pos}
 	}
 	close $fd;

	my @genes=keys %POS1;

	foreach my $g (@genes)
	{
		my @lg=split("\t",$g);
		my @p1=split("\n",$POS1{$g});
		my @p2=split("\n",$POS2{$g});
	
		my $pairing='no';
		my $dist='no';

		foreach my $pt1 (@p1)
		{
			my @pts1=split("\t",$pt1);
				
			foreach my $pt2 (@p2)
			{
				if($pt2=~/$pts1[0]/)
				{					
					my @pts2=split("\t",$pt2);
					if ((abs ($pts2[2] - $pts1[1]) < $maxdist) or (abs ($pts1[2] - $pts2[1]) < $maxdist)) {$dist='yes'}
					$pairing='yes';
				}		
			}
		}
		if($pairing eq 'no')
		{
			unless($P{$lg[0]} eq 'yes') {$P{$lg[0]}='no'}
		}
		elsif($pairing eq 'yes') {$P{$lg[0]}='yes'}

		if($dist eq 'no')
		{
			unless($D{$lg[0]} eq 'yes') {$D{$lg[0]}='no'}
		}
		elsif($dist eq 'yes') {$D{$lg[0]}='yes'}

	}
}
close $D;

my @genes=keys %D;

my $np;
my $nd;

my $res="gene\tPairing\tDist\n";
foreach my $g (@genes)
{
	$res.="$g\t$P{$g}\t$D{$g}\n";
	if($P{$g} eq 'yes') {$np++}
	if($D{$g} eq 'yes') {$nd++}
}

$res="#total no. genes:349\n#no. of genes with proper pairing of 100kb flanking sequences: $np\n#no. of genes inserted to non-genic regions: $nd\n$res";


open my $fd,">$oF";
print $fd $res;
close $fd;




