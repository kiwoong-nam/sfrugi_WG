#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/NSSSites

for i in $(seq 1 8521);
do
  echo $i
  cp seq/g$i.codeml.fa infile.fa
  /home/kiwoong/bioinformatics/paml-4.10.6/bin/codeml   
  mv result res/g$i.codeml
done



