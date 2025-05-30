#!/bin/bash
#SBATCH --mem=60G

module load bioinfo/samtools/1.14
module load devel/python/Python-3.11.1 devel/java/17.0.6
module load bioinfo/GATK/4.2.6.1 
module load bioinfo/VCFtools/0.1.16

cd /home/knam/work/sfrugi_WG/SNV/vcf

gatk VariantFiltration -R /home/knam/work/sfrugi_WG/SNV/ref/sfC.ver7.fa -V FC.vcf.gz -O FC.annotated.vcf.gz 

zcat FC.annotated.vcf.gz | grep -P 'PASS|#' | vcftools --vcf - --max-missing 0.2 --recode -c | bgzip -f > FC.filtered.vcf.gz
tabix -p vcf FC.filtered.vcf.gz

