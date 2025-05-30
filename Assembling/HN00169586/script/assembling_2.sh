#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/busco

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_98.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_98.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R3.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_99.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_99.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R3.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_92.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_92.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R3.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_97.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_97.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R3.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_89.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_89.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R3.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_90.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_90.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R3.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_95.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R1.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon  /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R1.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_95.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R1.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R1.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R2.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R2.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R1.fa  > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R2.fa

/home/kiwoong/bioinformatics/minimap2-2.5_x64-linux/minimap2 -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R2.fa /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz | gzip -f > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R3.paf.gz

/home/kiwoong/bioinformatics/racon-v1.4.3/build/bin/racon -t8 /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R3.paf.gz /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R2.fa > /home/kiwoong/Projects/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R3.fa

