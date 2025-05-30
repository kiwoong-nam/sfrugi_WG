#!/bin/bash

cd /home/knam/work/sfrugi_WG/SNV/gvcf

mv FC35.g.vcf.gz FC35_nc.g.vcf.gz

zcat FC35_nc.g.vcf.gz | head -n 64612877 | /usr/local/bioinfo/src/samtools/samtools-1.19/htslib-1.19/bgzip -c  > FC35.g.vcf.gz

/usr/local/bioinfo/src/samtools/samtools-1.19/htslib-1.19/tabix -p vcf FC35.g.vcf.gz


