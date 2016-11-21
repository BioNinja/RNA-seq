#!bin/bash
#$ -cwd
# Specify the kind of shell script you use, for example, bash
#$ -S /bin/bash
# join the error and standard output streams
#$ -j y
# set the required cpu time of your job;mem_req, num_proc could be passed to -l
##$ -l h_cpu=hh:mm:ss
# Export user's all environment variables. e.g. $HOME/bin
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



#mapping to reference genom and Count reads

set -e

#find . -name "*trim.fq.gz" | while read id; do echo ${id%%_R*}; done | sort -k1,1 | uniq > file_name_prefix.txt

sample=(./M/Sample_M_20160419_CGTACG_L006 ./M/Sample_M_20160301_ATGTCA_L003 ./M-T/Sample_M_T_20160301_AGTTCC_L003 ./M-T/Sample_M_T_20160419_GTTTCG_L006 ./T/Sample_T2_20160301_GTCCGC_L003 ./T/Sample_T1_20160301_CCGTCC_L003 ./T/Sample_T3_20160301_GTGAAA_L003)

gtf=~/genome/gtf_mouse/gencode.GRCm38.vM9.annotation.mm10.gtf
genome=/picb/external/isotex/genome/starIndex_mm10 
mkdir -p star_out
mkdir -p stringtie_out
#mapping using star, required at least 32G memory.
for var in ${sample[@]}
   do
    newname=$(echo ${var} | cut -d/ -f3)
    STAR --genomeDir $genome  --readFilesIn ${var}_R1_paired.trim.fq.gz ${var}_R2_paired.trim.fq.gz --readFilesCommand zcat --runThreadN 16 --outFileNamePrefix ./star_out/$newname.  --outSAMtype BAM SortedByCoordinate --outSAMstrandField intronMotif --alignEndsType EndToEnd --quantMode GeneCounts 
 
done


#calculate FPKM for each gene and transcpripts.
for var in ${sample[@]}
    do
       newname=$(echo ${var} | cut -d/ -f3)
       stringtie -e -B  -G $gtf -p 16 -o ./stringtie_out/$newname/$newname.gtf ./star_out/$newname.Aligned.sortedByCoord.out.bam

done
