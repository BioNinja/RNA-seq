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


gtf=~/genome/gtf_human/gencode.v19.annotation.gfold.gtf
#ls ../hisat_out/*bam | while read var;
 #   do
    #for sam file
    #~/program/gfold.V1.1.4/gfold count -ann ~/Genome/hg19/Homo_sapiens.Ensembl.GRCh37.75.gtf -tag ../${var}.sam -o ${var}.read_cnt
    newname=${var%%.sorted.bam}
  #  samtools view ${var} | gfold count -ann ${gtf}  -tag stdin -o ${newname##*/}.read_cnt
#done



sample=(Blank_combined U251_combined U251-DMSO_combined wmsg-13_combined wmsh-7_combined wtca-11_combined wtdr-11_combined wtdr-22_combined)

for var in ${sample[@]}
do
if [ "${var}" != "Blank_combined" ] ; then 
gfold diff -s1 Blank_combined -s2 ${var} -suf .read_cnt -o ${var}_VS_Blank_combined.diff
else
echo -e "skip same file"
fi


if [ "${var}" != "U251-DMSO_combined" ]; then
gfold diff -s1 U251-DMSO_combined -s2 ${var} -suf .read_cnt -o ${var}_VS_U251-DMSO_combined.diff
else
echo -e "skip same file, again"
fi

done


