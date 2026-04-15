#!/bin/bash

module load devel/python/Python-3.11.1
module load bioinfo/bedtools/2.30.0

cd /home/knam/work/sfrugi_WG/AFS/X/freq

for FILE in *; do
  bedtools sort -i $FILE | bedtools merge -i -  > "../merged/${FILE}"
done

