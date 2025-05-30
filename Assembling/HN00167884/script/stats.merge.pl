use strict;

my $WD='/home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884'; ##############
my $IDer='FC'; ##############################################################

$WD=~/\w+$/;
my $batch =$&;

my $Idir="$WD/rawfq";
my $Odir="$WD/assemblies";
my $Gdir="$WD/polished";
my $Bdir="$WD/busco";
my $Sdir="$WD/stats";

my $output="$WD/result.txt";

my %RS;

GETES('throughput');
GETES('assembly');
GETES('busco_summary');

my @id=keys %RS;

my $res="batch\tID\tread.no\tread.len\tassembly.len\tassembly.N50\tassembly.N90\tassembly.contigs\tbusco.S\tbusco.D\tbusco.F\tbusco.M\tbusco.n\n";

foreach my $i (@id)
{
	$res.="$batch\t$i\t$RS{$i}\n";
}
$res=~s/\t\n/\n/g;

open my $fd,">$output";
print $fd $res;
close $fd;

print $res;

sub GETES
{
	(my $F)=(@_);
	my $input="$Sdir/$F.txt";
	open my $fd,$input;
	while(<$fd>)
	{
		$_=~/($IDer\d+)[\.|\t]/;
		my $id=$1;
		if($id eq '') {next}
	
		$_=~s/\n//;
		my @s=split("\t",$_);
		shift @s;
		$RS{$id}.=join("\t",@s)."\t";
		undef $id;
	}
	close $fd;
}

