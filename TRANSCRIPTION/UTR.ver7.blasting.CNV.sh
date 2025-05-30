#!/bin/bash

cd /home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/

for f in /home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/Seqs/CNV/*
  do s=$(echo $f | sed 's/^.*\///');
  echo $s
  blastn -db ver7 -out CNV/$s -query $f -outfmt "6 qseqid sseqid sstart send length pident qcovs"
#  blastn -db ver7 -out CNV/$s -query $f
  gzip -f CNV/$s
done

