#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNV

echo '# of CNV genes:' > CNV_counts
cat list.txt | grep -c yes >> CNV_counts
echo '' >> CNV_counts

echo '# of non CNV genes:' >> CNV_counts
cat list.txt | grep -c no >> CNV_counts
echo '' >> CNV_counts

cat list.txt | grep yes > CNV.txt
cat list.txt | grep -v yes > noCNV.txt

