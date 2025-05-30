#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=150G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/busco

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_98_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_98 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_98.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_98.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_99_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_99 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_99.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_99.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_92_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_92 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_92.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_92.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_89_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_89 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_89.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_89.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_95_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_95 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_95.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_95.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_90_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_90 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_90.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_90.fa

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/rawfq/FC_97_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_97 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_97.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/assemblies/FC_97.fa

