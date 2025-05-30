#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/

for f in /home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/Seqs/nonCNV/*
  do s=$(echo $f | sed 's/^.*\///');
  echo $s
  blastn -db ver7 -out nonCNV/$s -query $f -outfmt "6 qseqid sseqid sstart send length pident qcovs"
  gzip -f nonCNV/$s
done


