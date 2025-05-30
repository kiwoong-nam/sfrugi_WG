#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=150G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/busco

perl ../script/stats.assembly.pl
perl ../script/stats.throughput.pl

wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC37 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC37.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC37.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC37.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC37.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC37_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC37.R3.fa -o FC37 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC79 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC79.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC79.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC79.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC79.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC79_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC79.R3.fa -o FC79 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC35 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC35.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC35.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC35.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC35.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC35_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC35.R3.fa -o FC35 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC72 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC72.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC72.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC72.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC72.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC72_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC72.R3.fa -o FC72 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC71 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC71.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC71.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC71.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC71.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC71_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC71.R3.fa -o FC71 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC81 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC81.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC81.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC81.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC81.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC81_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC81.R3.fa -o FC81 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC78 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC78.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC78.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC78.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC78.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC78_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC78.R3.fa -o FC78 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC54 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC54.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC54.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC54.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC54.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC54_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC54.R3.fa -o FC54 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC52 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC52.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC52.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC52.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC52.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC52_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC52.R3.fa -o FC52 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC76 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC76.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC76.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC76.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC76.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC76_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC76.R3.fa -o FC76 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC77 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC77.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC77.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC77.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC77.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC77_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC77.R3.fa -o FC77 -l lepidoptera_odb10 -m geno -c 8



wtdbg2 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz -o /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC55 -t 8 -x sq -g 400m

wtpoa-cns -t 8 -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC55.ctg.lay.gz -fo /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC55.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC55.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R1.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R1.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/assemblies/FC55.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R1.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R1.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R2.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R2.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R1.fa  > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R2.fa

minimap2 -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R2.fa /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz | gzip -f > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R3.paf.gz

racon -t8 /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/rawfq/FC55_HiFi.fastq.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R3.paf.gz /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R2.fa > /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R3.fa

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00167884/polished/FC55.R3.fa -o FC55 -l lepidoptera_odb10 -m geno -c 8


perl ../script/stats.assembly.pl
bash ../script/stats.busco.sh
perl ../script/stats.merge.pl

