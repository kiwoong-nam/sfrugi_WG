#!/bin/bash

#Version: 1.17 (using htslib 1.17)

cd /home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/mapping

samples=('MORT2_MM2' 'MORT2-MP' 'MORT2-MR' 'MORT2_MM1')
category=( 'Upstream.CNV' 'Upstream.nonCNV' 'CDS' 'Intron' 'Intergenic' 'TE')

for s in "${samples[@]}"; do
     echo $s
     samtools depth -aa -H -o ../readdepth/counts/$s $s.sorted.bam
     gzip ../readdepth/counts/$s
done


#for s in "${samples[@]}"; do
#  for c in "${category[@]}"; do
#      echo $s 	$c
#      samtools depth -aa -H -b /home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/readdepth/bed/$c.bed -o ../readdepth/counts/$s.$c $s.sorted.bam
#  done 
#done



