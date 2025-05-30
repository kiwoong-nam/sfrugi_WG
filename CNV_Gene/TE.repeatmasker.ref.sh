#!/bin/bash
#SBATCH --mem=50G
#SBATCH -c 8

module load devel/python/Python-3.6.3
module load bioinfo/RepeatMasker/4.1.5

cd /home/knam/work/sfrugi_WG/POSITION/TE/repeatmasker

cp /home/knam/work/sfrugi_WG/POSITION/TE/repeatmodeler/sfC.ver7.fa .

#RepeatMasker -xsmall -lib /home/knam/work/sfrugi_WG/POSITION/TE/repeatmodeler/RM_2475944.ThuNov282041512024/consensi.fa.classified  -dir ./ver7_RepeatModeler -pa 8 -e wublast sfC.ver7.fa

#RepeatMasker -xsmall -lib /home/knam/work/sfrugi_WG/POSITION/TE/repeatmasker/SpodoCorn_v7.0/TE_DENOVO/Test2022_SfCv7_sim_denovoLibTEs_filtered.fa -dir ./ver7_REPET -pa 8 -e wublast sfC.ver7.fa

RepeatMasker -xsmall -lib /home/knam/work/sfrugi_WG/POSITION/TE/repeatmodeler/RM_2475944.ThuNov282041512024/consensi.fa.classified -dir ./ncbi_RepeatModeler -pa 8 -e wublast /home/knam/work/sfrugi_WG/RefSeq/GCF_023101765.2_AGI-APGP_CSIRO_Sfru_2.0_genomic.fna.gz

rm sfC.ver7.fa
