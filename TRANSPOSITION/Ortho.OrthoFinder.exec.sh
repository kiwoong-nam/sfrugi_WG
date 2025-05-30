#!/bin/bash
#SBATCH --cpus-per-task=16

module load devel/Miniconda/Miniconda3
module load bioinfo/OrthoFinder/2.5.5

cd /home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input/seq
orthofinder -t 16 -a 16 -f /home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/input/seq -o /home/knam/work/sfrugi_WG/TRANSPOSITION/Ortho/OrthoFinder/res





