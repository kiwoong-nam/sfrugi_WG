#!/bin/bash

module load devel/python/Python-3.11.1
module load bioinfo/bedtools/2.30.0

aD="/home/knam/work/sfrugi_WG/AFS/X/merged"
bD="/home/knam/work/sfrugi_WG/AFS/X/freq"
oD="/home/knam/work/sfrugi_WG/AFS/X/count"

cd $aD

for GENE in *; do	
  bedtools intersect -a "$GENE" -b "$bD/$GENE" -wa -wb | bedtools groupby -i - -g 1,2,3 -c 7 -o count_distinct > "$oD/$GENE"
done


