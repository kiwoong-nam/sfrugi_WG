#!/bin/bash
#SBATCH --mem=60G

module load bioinfo/samtools/1.14
module load devel/python/Python-3.11.1 devel/java/17.0.6
module load bioinfo/GATK/4.2.6.1 
module load bioinfo/VCFtools/0.1.16

cd /home/knam/work/sfrugi_WG/SNV/vcf

gatk SelectVariants -R /home/knam/work/sfrugi_WG/SNV/ref/sfC.ver7.fa -select-type SNP -V FC.filtered.phased.vcf.gz -O FC.filtered.SNV.phased.vcf.gz 


