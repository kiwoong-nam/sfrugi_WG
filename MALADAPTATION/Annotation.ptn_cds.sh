#!/bin/bash

cd /home/knam/work/sfrugi_WG/MALADAPTATION/Annotation

/home/knam/save/programs/gffread/gffread ver7.final.gff -g sfC.ver7.fa -x sfC.final.cds.fa
/home/knam/save/programs/gffread/gffread ver7.final.gff -g sfC.ver7.fa -y sfC.final.ptn.fa

