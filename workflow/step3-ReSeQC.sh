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
set -e
#bam_path.txt
bam_path=$1
rseqc_ann_bed=/picb/external/isotex/genome/rseqc_ann/hg19.HouseKeepingGenes.bed
mkdir -p RSeQC_out
geneBody_coverage.py -r ${rseqc_ann_bed} -i ${bam_path}  -o ./RSeQC_out/RSeQC

multiqc .
