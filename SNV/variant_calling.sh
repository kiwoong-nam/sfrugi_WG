#!/bin/bash
#SBATCH --mem=120G

module load devel/python/Python-3.11.1 devel/java/17.0.6
module load bioinfo/GATK/4.2.6.1 

cd /home/knam/work/sfrugi_WG/SNV/gvcf

gatk GenotypeGVCFs -R /home/knam/work/sfrugi_WG/SNV/ref/sfC.ver7.fa --variant FC.g.vcf.gz -O ../vcf/FC.vcf.gz -all-sites

