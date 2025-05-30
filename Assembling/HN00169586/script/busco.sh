#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=50G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/busco

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_98.R3.fa -o FC_98 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_99.R3.fa -o FC_99 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_92.R3.fa -o FC_92 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_97.R3.fa -o FC_97 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_89.R3.fa -o FC_89 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_90.R3.fa -o FC_90 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/polished/FC_95.R3.fa -o FC_95 -l lepidoptera_odb10 -m geno -c 8



