#!/bin/sh
#$ -cwd
# Specify the kind of shell script you use, for example, bash
#$ -S /bin/bash
# join the error and standard output streams
#$ -j y
# set the required cpu time of your job;mem_req, num_proc could be passed to -l
##$ -l h_cpu=hh:mm:ss
# Export user specified environment variables. e.g. $HOME/bin
#$ -V
# don't flood myself with e-mail
#$ -m n
# this is my e-mail address
##$ -M yaochengxu@picb.ac.cn
# notify me about pending SIG_STOP and SIG_KILL
##$ -notify
# name of the job
##$ -N MyJob
#e.g.
#echo -e "You job ran successfully"

# sample info
#Sample_WGC078835R DMSO
#Sample_WGC078836R YPA
#Sample_WGC079678R DMSO
#Sample_WGC079679R YPA
#Sample_WGC079680R DMSO
#Sample_WGC079681R YPA
set -e

gtf=~/genome/gtf_human/gencode.v19.annotation.gtf

sample=(Blank_combined U251_combined U251-DMSO_combined wmsg-13_combined wmsh-7_combined wtca-11_combined wtdr-11_combined wtdr-22_combined)
var=$1
#for var in ${sample[@]}
#do
python /picb/external/isotex/program/rMATS.3.2.5/RNASeq-MATS.py -b2 ./hisat_out/${var}.sorted.bam -b1 ./hisat_out/Blank_combined.sorted.bam -gtf $gtf  -o ./rMATS_out/${var}_vs_Blank_combined -t paried -len 150 -a 1 -c 0.0001 -analysis U -novelSS 0

python /picb/external/isotex/program/rMATS.3.2.5/RNASeq-MATS.py -b2 ./hisat_out/${var}.sorted.bam -b1 ./hisat_out/U251-DMSO_combined.sorted.bam -gtf $gtf  -o ./rMATS_out/${var}_vs_U251-DMSO_combined -t paried -len 150 -a 1 -c 0.0001 -analysis U -novelSS 0

#done
