#!/bin/bash

#ancestral : /usr/local/bioinfo/src/BUSCO/datasets_odb10/lepidoptera_odb10/ancestral

cd /home/kiwoong/Projects/sfrugi_WG/SYNTHENY/Grouping/BUSCO_Blast

makeblastdb -in /home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/fx/frugiperda.fa -dbtype prot -out frugiperda

blastp -db frugiperda -query ancestral -out busco.blastP -outfmt 6




