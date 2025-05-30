#!/bin/bash

cd /home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586/busco

grep C: */s* | sed 's/\/.*\[//' | sed 's/.:/\t/g' | sed 's/\]//' | sed 's/%//g' | sed 's/,//g' > ../stats/busco_summary.txt


