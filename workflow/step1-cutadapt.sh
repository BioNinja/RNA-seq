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
mkdir -p trim
sample=(./M/Sample_M_20160419_CGTACG_L006 ./M/Sample_M_20160301_ATGTCA_L003 ./M-T/Sample_M_T_20160301_AGTTCC_L003 ./M-T/Sample_M_T_20160419_GTTTCG_L006 ./T/Sample_T2_20160301_GTCCGC_L003 ./T/Sample_T1_20160301_CCGTCC_L003 ./T/Sample_T3_20160301_GTGAAA_L003)

for var in ${sample[@]}
do
cutadapt -q 25 -O 5 -e 0.1 -m 50 -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACATTCCTTTATCTCGTATGCCGTCTTCTGCTTG -a "A{100}" -g "T{100}"   -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT  -A "A{100}" -G "T{100}" -o trim/${var##*/}_R1.trim.fq.gz -p trim/${var##*/}_R2.trim.fq.gz ${var}_R2.fastq.gz ${var}_R2.fastq.gz | tee trim/${var##*/}_trim_report.txt

done

mkdir -p  QC_results_cutadapt
fastqc -t 8 ./trim/*trim.fq.gz -o QC_results_cutadapt
