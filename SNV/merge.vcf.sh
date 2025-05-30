#!/bin/bash
#SBATCH --mem=120G

module load devel/python/Python-3.11.1 devel/java/17.0.6
module load bioinfo/GATK/4.2.6.1 

cd /home/knam/work/sfrugi_WG/SNV/gvcf

gatk CombineGVCFs -R /home/knam/work/sfrugi_WG/SNV/ref/sfC.ver7.fa --variant FC01.g.vcf.gz --variant FC_101.g.vcf.gz --variant FC_106.g.vcf.gz --variant FC37.g.vcf.gz --variant FC72.g.vcf.gz --variant FC81.g.vcf.gz --variant FC_89.g.vcf.gz --variant FC02.g.vcf.gz --variant FC_102.g.vcf.gz --variant FC32.g.vcf.gz --variant FC52.g.vcf.gz --variant FC76.g.vcf.gz --variant FC82.g.vcf.gz --variant FC_90.g.vcf.gz --variant FC_99.g.vcf.gz --variant FC03.g.vcf.gz --variant FC_103.g.vcf.gz --variant FC33.g.vcf.gz --variant FC54.g.vcf.gz --variant FC77.g.vcf.gz --variant FC_84.g.vcf.gz --variant FC_92.g.vcf.gz --variant FC04.g.vcf.gz --variant FC_104.g.vcf.gz --variant FC35.g.vcf.gz --variant FC55.g.vcf.gz --variant FC78.g.vcf.gz --variant FC_85.g.vcf.gz --variant FC_95.g.vcf.gz --variant FC_100.g.vcf.gz --variant FC_105.g.vcf.gz --variant FC71.g.vcf.gz --variant FC79.g.vcf.gz --variant FC_88.g.vcf.gz --variant FC_97.g.vcf.gz -O FC.g.vcf.gz

