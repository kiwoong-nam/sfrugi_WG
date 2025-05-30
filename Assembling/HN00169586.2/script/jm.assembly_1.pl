use strict;

my $WD='/home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2';

my $Idir="/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq";
my $Odir="$WD/assemblies";
my $Gdir="$WD/polished";
my $Bdir="$WD/busco";

my $output="/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586.2/script/assembling_1.sh";

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

my $j=
'#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=150G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


';

$j.="cd $Bdir\n\n";

foreach my $f (@files)
{
	unless($f=~/(\w+)_HiFi.fastq.gz/){next}
	my $id=$1;

	my $seq="/home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/$f";     
	my $asm="$Odir/$id.fa";
	my $assemblyF="$Gdir/$id.R3.fa";
        
	$j.="wtdbg2 -i $seq -o $Odir/$id -t 8 -x sq -g 400m\n\n";
	$j.="wtpoa-cns -t 8 -i $Odir/$id.ctg.lay.gz -fo $Odir/$id.fa\n\n";

#	$j.="minimap2 -t8 $asm $seq | gzip -f > $Gdir/$id.R1.paf.gz\n\n";
#	$j.="racon -t8 $seq $Gdir/$id.R1.paf.gz $Odir/$id.fa > $Gdir/$id.R1.fa\n\n";

#	$j.="minimap2 -t8 $Gdir/$id.R1.fa $seq | gzip -f > $Gdir/$id.R2.paf.gz\n\n";
#	$j.="racon -t8 $seq $Gdir/$id.R2.paf.gz $Gdir/$id.R1.fa  > $Gdir/$id.R2.fa\n\n";

#	$j.="minimap2 -t8 $Gdir/$id.R2.fa $seq | gzip -f > $Gdir/$id.R3.paf.gz\n\n";
#	$j.="racon -t8 $seq $Gdir/$id.R3.paf.gz $Gdir/$id.R2.fa > $Gdir/$id.R3.fa\n\n";


#       $j.="busco -i $assemblyF -o $id -l lepidoptera_odb10 -m geno -c 8\n\n\n\n";
}

open my $fd,">$output";
print $fd $j;
close $fd;

