#!/bin/bash

VCFF=/home/kiwoong/Projects/sfrugi_WG/SNV/vcf/FC.filtered.SNV.phased.vcf.gz

cd /home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/PI

vcftools --gzvcf $VCFF --window-pi 100000 --out SNP


