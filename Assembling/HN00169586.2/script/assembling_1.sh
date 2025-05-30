#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=150G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/busco

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_100_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_100 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_100.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_100.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_105_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_105 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_105.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_105.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_102_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_102 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_102.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_102.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_88_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_88 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_88.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_88.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_104_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_104 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_104.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_104.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_106_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_106 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_106.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_106.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_101_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_101 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_101.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_101.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC82_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC82 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC82.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC82.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_84_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_84 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_84.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_84.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_85_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_85 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_85.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_85.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/rawfq/FC_103_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_103 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_103.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/assemblies/FC_103.fa

