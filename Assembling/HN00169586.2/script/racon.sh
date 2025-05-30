#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=100G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/busco

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_88.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_88.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_85.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_85.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_105.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_105.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_106.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_106.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_101.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_101.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_100.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_100.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_84.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_84.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_103.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_103.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_104.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_104.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC82.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC82.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R3.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_102.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_102.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R3.fa

