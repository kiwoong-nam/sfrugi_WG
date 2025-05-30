#!/bin/bash
#SBATCH -c 8
#SBATCH --mem=50G

module load bioinfo/wtdbg2-2.5
module load bioinfo/minimap2-2.5
module load bioinfo/racon-v1.4.3
module load system/Miniconda3-4.7.10
module load bioinfo/busco-5.2.2


cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/busco

busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_88.R3.fa -o FC_88 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_85.R3.fa -o FC_85 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_105.R3.fa -o FC_105 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_106.R3.fa -o FC_106 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_101.R3.fa -o FC_101 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_100.R3.fa -o FC_100 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_84.R3.fa -o FC_84 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_103.R3.fa -o FC_103 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_104.R3.fa -o FC_104 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC82.R3.fa -o FC82 -l lepidoptera_odb10 -m geno -c 8



busco -i /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/polished/FC_102.R3.fa -o FC_102 -l lepidoptera_odb10 -m geno -c 8



