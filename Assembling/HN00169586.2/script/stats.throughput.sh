#!/bin/bash
#SBATCH -c 11
#SBATCH --mem=30G

cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2/script
perl stats.throughput.pl


