#!/bin/bash
#SBATCH --cpus-per-task 32

module load devel/python/Python-3.6.3
module load bioinfo/RepeatModeler/2.0.4

cd /home/knam/work/sfrugi_WG/POSITION/TE/repeatmodeler

BuildDatabase -name ver7 sfC.ver7.fa
RepeatModeler -threads 32 -database ver7


