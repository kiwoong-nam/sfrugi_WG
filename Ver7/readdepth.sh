#!/bin/bash

#Version: 1.17 (using htslib 1.17)

BAMD=/home/kiwoong/Projects/sfrugi_WG/SNV/bam

cd /home/kiwoong/Projects/sfrugi_WG/Ver7/readdepth

samples=('FC01' 'FC02' 'FC03' 'FC04' 'FC_100' 'FC_101' 'FC_102' 'FC_103' 'FC_104' 'FC_105' 'FC_106' 'FC32' 'FC33' 'FC35' 'FC37' 'FC52' 'FC54' 'FC55' 'FC71' 'FC72' 'FC76' 'FC77' 'FC78' 'FC79' 'FC81' 'FC82' 'FC_84' 'FC_85' 'FC_88' 'FC_89' 'FC_90' 'FC_92' 'FC_95' 'FC_97' 'FC_98' 'FC_99')

for s in "${samples[@]}"; do
     echo $s
     samtools depth -aa -H -o $s $BAMD/$s.bam
     gzip $s
done

