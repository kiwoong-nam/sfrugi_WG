#!/bin/bash

#SBATCH -c 8
#SBATCH --mem=50G


cd /home/knam/work/sfrugi_WG/MALADAPTATION/Annotation

/home/knam/save/programs/miniprot/miniprot -t8 -d ver7 sfC.ver7.fa

/home/knam/save/programs/miniprot/miniprot --gff -t8 ver7 /home/knam/work/sfrugi_WG/RefSeq/uniq_gene.fa > ver7.gff

