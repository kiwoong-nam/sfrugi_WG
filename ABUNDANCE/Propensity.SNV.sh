#!/bin/bash

module load bioinfo/VCFtools/0.1.16

vcfF=/home/knam/work/sfrugi_WG/SNV/vcf/FC.filtered.SNV.phased.vcf.gz

cd /home/knam/work/sfrugi_WG/ABUNDANCE/Propensity

vcftools --gzvcf $vcfF --window-pi 100000 --out SNV

