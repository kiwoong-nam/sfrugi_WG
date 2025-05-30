#!/bin/bash

#version 2.12.0+

cd /home/kiwoong/Projects/sfrugi_WG/CNV_Gene/Selfing/

makeblastdb -in CNVptn.fa -out CNV -dbtype prot

blastp -db CNV -query CNVptn.fa -outfmt "6 qseqid sseqid pident qcovs" -out Selfing


