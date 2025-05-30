use strict;

my $WD='/home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586';
my $Idir="$WD/rawfq";
my $Odir="$WD/assemblies";
my $Gdir="$WD/polished";
my $Bdir="$WD/busco";

my $output="$WD/script/assembling_2.sh";

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

my $j=
'#!/bin/bash

';

$j.="cd $Bdir\n\n";

foreach my $f (@files)
{
	unless($f=~/(\w+)_HiFi.fastq.gz/){next}
	my $id=$1;

	my $seq="$Idir/$f";     
	my $asm="$Odir/$id.fa";
	my $assemblyF="$Gdir/$id.R3.fa";
        
	$j.="/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 $asm $seq | gzip -f > $Gdir/$id.R1.paf.gz\n\n";
	$j.="/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  $seq $Gdir/$id.R1.paf.gz $Odir/$id.fa > $Gdir/$id.R1.fa\n\n";

	$j.="/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 $Gdir/$id.R1.fa $seq | gzip -f > $Gdir/$id.R2.paf.gz\n\n";
	$j.="/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 $seq $Gdir/$id.R2.paf.gz $Gdir/$id.R1.fa  > $Gdir/$id.R2.fa\n\n";

	$j.="/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 $Gdir/$id.R2.fa $seq | gzip -f > $Gdir/$id.R3.paf.gz\n\n";
	$j.="/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 $seq $Gdir/$id.R3.paf.gz $Gdir/$id.R2.fa > $Gdir/$id.R3.fa\n\n";

#        $j.="busco -i $assemblyF -o $id -l lepidoptera_odb10 -m geno -c 8\n\n\n\n";
}

open my $fd,">$output";
print $fd $j;
close $fd;

