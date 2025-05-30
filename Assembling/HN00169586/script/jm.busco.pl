use strict;

my $WD='/home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586';

my $Idir="/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq";
my $Odir="$WD/assemblies";
my $Gdir="$WD/polished";
my $Bdir="$WD/busco";

my $output="/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/script/busco.sh";

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

my $j=
'#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=50G

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

	my $seq="$Idir/$f";     
	my $asm="$Odir/$id.fa";
	my $assemblyF="$Gdir/$id.R3.fa";
        
       $j.="busco -i $assemblyF -o $id -l lepidoptera_odb10 -m geno -c 8\n\n\n\n";
}

open my $fd,">$output";
print $fd $j;
close $fd;

