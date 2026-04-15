#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/Assembly_Syntheny/nc

for PAF in *.paf; do

    BASE=$(basename $PAF .paf)
    echo $BASE
    /home/kiwoong/bioinformatics/paf2dotplot/paf2dotplot.r -f $BASE.paf -p 10 -q 1000 -m 1000 -s
    convert $BASE.paf.pdf -gravity West -chop 59x0 -gravity North -chop 0x34 $BASE.pdf
done

rm *.paf.pdf
mv *pdf ../Paf2dotplot/

cd ../Paf2dotplot

montage -label '%t' *.pdf -tile 6x6 -geometry +5+5 -pointsize 40 ../paf2dotplot.pdf
       
