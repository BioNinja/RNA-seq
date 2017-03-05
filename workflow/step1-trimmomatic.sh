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
sample=(./M/Sample_M_20160419_CGTACG_L006 ./M/Sample_M_20160301_ATGTCA_L003 ./M-T/Sample_M_T_20160301_AGTTCC_L003 ./M-T/Sample_M_T_20160419_GTTTCG_L006 ./T/Sample_T2_20160301_GTCCGC_L003 ./T/Sample_T1_20160301_CCGTCC_L003 ./T/Sample_T3_20160301_GTGAAA_L003)

for var in ${sample[@]}
    do
	trimmomatic PE -threads 16 -phred33 -trimlog ${var}.trim.log  ${var}_R1.fastq.gz ${var}_R2.fastq.gz  ${var}_R1_paired.trim.fq.gz ${var}_R1_unpaired.trim.fq.gz ${var}_R2_paired.trim.fq.gz ${var}_R2_unpaired.trim.fq.gz ILLUMINACLIP:./TruSeq3-PE.fa:2:30:10 LEADING:10 TRAILING:20 SLIDINGWINDOW:4:25 MINLEN:50

done
