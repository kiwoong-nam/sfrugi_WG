#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=150G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/busco

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC01 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC01.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC01.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC01.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC01.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC01_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC01.R3.fa -o FC01 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC33 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC33.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC33.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC33.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC33.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC33_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC33.R3.fa -o FC33 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC02 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC02.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC02.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC02.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC02.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC02_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC02.R3.fa -o FC02 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC04 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC04.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC04.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC04.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC04.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC04_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC04.R3.fa -o FC04 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC03 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC03.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC03.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC03.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC03.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC03_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC03.R3.fa -o FC03 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC32 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC32.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC32.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC32.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/assemblies/FC32.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/rawfq/FC32_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00165452/polished/FC32.R3.fa -o FC32 -l lepidoptera_odb10 -m geno -c 8



