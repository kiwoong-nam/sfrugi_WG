use strict;
use List::Util qw(max);

my $ID='/home/knam/work/sfrugi_WG/AFS/Flanking/minimap/mapping';
my $oD="/home/knam/work/sfrugi_WG/AFS/X/freq";

my $maxdist=100;
my $mincoverage=80000;

my %GF;
my %Genes;
my %Samples;

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
			
		foreach my $pt1 (@p1)
		{
			my @pts1=split("\t",$pt1);
				
			foreach my $pt2 (@p2)
			{
				if($pt2=~/$pts1[0]/)
				{					
					my @pts2=split("\t",$pt2);
					if ((abs ($pts2[2] - $pts1[1]) < $maxdist) or (abs ($pts1[2] - $pts2[1]) < $maxdist))
					{
						my @poss=(sort{$a <=> $b}($pts1[1],$pts1[2],$pts2[1],$pts2[2]))[0,3];
						unshift @poss,$pts1[0];
						my $k="$lg[0]\t$sample";
						$GF{$k}.=join("\t",@poss)."\n";
						$Samples{$sample}=1;
						$Genes{$lg[0]}=1;
					}
				}		
			}
		}
	}
}
close $D;

my @genes=keys %Genes;
my @samples=keys %Samples;

my %Res;
foreach my $g (@genes)
{
	foreach my $sa (@samples)
	{
		my $k="$g\t$sa";
		if($GF{$k} eq '') {next}
		my @RSKT=split("\n",$GF{$k});

		foreach my $r (@RSKT)
		{
			$Res{$g}.="$r\t$sa\n";
		}
	}
}

my @RGs=keys %Res;
foreach my $r (@RGs)
{
	my $oF="$oD/$r";
	
	open my $fd,">$oF";
	print $fd $Res{$r};
	close $fd;
}


