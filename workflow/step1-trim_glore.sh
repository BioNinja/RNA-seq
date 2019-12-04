#!bin/bash
OutPath="."
CleanFastqcPATH="./fastqc_clean"
read1=
read2=

trim_galore -q 20 --phred33 --fastqc --stringency 1 --fastqc_args "--outdir $CleanFastqcPath" -e 0.1 --dont_gzip --length 35 -o $OutPath --paired $read1 $read2 >$Sample.trimgalore.log

