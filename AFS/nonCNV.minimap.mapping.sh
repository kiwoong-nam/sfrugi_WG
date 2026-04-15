#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/AFS/nonCNV/seq/fasta

for f in *.flanking.fa
do
    SAMPLE=$(basename $f .flanking.fa)
    echo "Processing sample: $SAMPLE"
    minimap2 -t 8 -x asm20 /home/kiwoong/Projects/sfrugi_WG/AFS/Flanking/minimap/sfC.ver7.mmi $f > /home/kiwoong/Projects/sfrugi_WG/AFS/nonCNV/minimap/mapping/${SAMPLE}.paf    
done

