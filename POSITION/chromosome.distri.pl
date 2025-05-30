use strict;

my $DI='/home/knam/work/sfrugi_WG/POSITION/chromosome/chromosome';
my $gffF='/home/knam/work/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff';
my $fO='/home/knam/work/sfrugi_WG/POSITION/chromosome/distri.txt';
my $B=1000;

my @genes;
open my $fd,$gffF;
while(<$fd>)
{
	unless($_=~/mRNA/) {next}
	$_=~s/HiC_scaffold_//;
	my @s=split("\t",$_);

	$_=~/Target=(\w+)/;
	my $id=$1;
	push @genes,$id;
}
close $fd;

opendir my $D,$DI;
my @files=readdir($D);
close $D;

my $res="sample\tchro\tmean\tu.ci\tl.ci\n";

foreach my $f (@files)
{
	unless($f=~/F/) {next}
	open my $fd,"$DI/$f";
	my @data=<$fd>;
	close $fd;

	# bg
	my $bg=calct(@data);	
	my @bgR=split("\t",$bg);
	#
	my @bts;
	for(my $b=0;$b<$B;$b++)
	{
		my @bd;
		for(my $i=0;$i<=$#data;$i++)
		{
			push @bd,$data[int rand ($#data+1)];
		}
		
		my $btr=calct(@data);
		push @bts,$btr;
	}
	
	for(my $i=1;$i<30;$i++)
	{
		my $bgC=$bgR[$i];
		
		my @btscalc;
		
		foreach my $l (@bts)
		{
			my @s=split("\t",$l);
			push @btscalc,$s[$i];
		}
		@btscalc=sort {$a<=>$b} @btscalc;
		
		$res.="$f\t$i\t$bgC\t$btscalc[975]\t$btscalc[25]\n";
	}
}

$res=~s/\t\t/\t0\t/g;
$res=~s/\t\t/\t0\t/g;
$res=~s/\t\n/\t0\n/g;
$res=~s/\.chrs\.dupl//g;

open my $fd,">$fO";
print $fd $res;
close $fd;

sub calct 
{
	my (@data)=(@_);

	my @chrs;
	foreach my $d (@data)
	{
                $d=~s/\n//;
                my @s=split("\t",$d);
                my @cr=split("n",$s[1]);
                foreach my $c (@cr) {push @chrs,$c}
        }
	my @counts;
	foreach my $c (@chrs) {$counts[$c]++}
	my $res=join("\t",@counts);
	$res=~s/\t\t/\t0\t/g;
	return $res;
}

