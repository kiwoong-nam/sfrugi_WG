#!/bin/bash

#Protein-Protein BLAST 2.12.0+

cd /home/kiwoong/Projects/sfrugi_WG/SYNTHENY/DAGChainer/fx

makeblastdb -in frugiperda.fa -dbtype prot

blastp -db frugiperda.fa -query exigua.fa -out allvsall.exigua -outfmt 6
blastp -db frugiperda.fa -query litura.fa -out allvsall.litura -outfmt 6

