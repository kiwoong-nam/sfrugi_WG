#!/bin/bash

#Bowtie 2 version 2.4.4

FQD='/home/kiwoong/Projects/sfrugi_SenegalHostPlant/RNA_seq_2/mapping/fq/filtered'
REF='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ref/ver7'
OUTD='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/mapping'

samples=('MORT2_MM2' 'MORT2-MP' 'MORT2-MR' 'MORT2_MM1')

for s in "${samples[@]}"; do
        bowtie2 --threads 8 --local -x $REF -U $FQD/$s.truncated.gz | samtools sort -o $OUTD/$s.sorted.bam
done 



