#!/bin/bash

module load bioinfo/minimap2-2.19

cd /work/knam/sfrugi_WG/SNV/ref

minimap2 -x map-hifi -d sfC.ver7.mmi sfC.ver7.fa


