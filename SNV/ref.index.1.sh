#!/bin/bash 
module load bioinfo/gatk-4.2.6.1

cd /work/knam/sfrugi_WG/SNV/ref

/home/knam/save/programs/samtools-1.9/samtools faidx sfC.ver7.fa

gatk CreateSequenceDictionary -R /home/knam/work/sfrugi_WG/SNV/ref/sfC.ver7.fa -O /home/knam/work/sfrugi_WG/SNV/ref/sfC.ver7.dict

