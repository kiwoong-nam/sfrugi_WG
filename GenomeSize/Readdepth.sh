#!/bin/bash

InD="/home/kiwoong/Projects/sfrugi_WG/SNV/bam"

cd /home/kiwoong/Projects/sfrugi_WG/GenomeSize/Readdepth
for f in "$InD"/FC*.bam
do
   sampleN=$(basename "$f" .bam)
   echo $sampleN
   /home/kiwoong/bioinformatics/mosdepth -n --fast-mode --by 100000 -Q 20 $sampleN.bed $f 
done

