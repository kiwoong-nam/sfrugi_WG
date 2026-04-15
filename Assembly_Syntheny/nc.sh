#!/bin/bash

ID="/home/kiwoong/Projects/sfrugi_WG/Assembly_Syntheny/minimap/"

cd /home/kiwoong/Projects/sfrugi_WG/Assembly_Syntheny/nc

for PAF in $ID/*.paf; do

    BASE=$(basename $PAF .paf)
    sed 's/HiC_scaffold_//g' "$PAF" > "${BASE}.paf"
done

