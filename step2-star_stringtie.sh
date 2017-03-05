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


gtf=~/genome/gtf_mouse/gencode.GRCm38.vM9.annotation.mm10.gtf
genome=/picb/external/isotex/genome/starIndex_mm10 
mkdir -p star_out
mkdir -p ballgown
#mapping using star, required at least 32G memory.
find . -name "*trim.fq.gz" | while read id; do echo ${id%%_R*}; done | sort -k1,1 | uniq | while read var;
do
newname=${var##*/}
STAR --genomeDir $genome  --readFilesIn ${var}_R1.trim.fq.gz ${var}_R2.trim.fq.gz --readFilesCommand zcat --runThreadN 16 --outFileNamePrefix ./star_out/$newname.  --outSAMtype BAM SortedByCoordinate --outSAMstrandField intronMotif --alignEndsType EndToEnd --quantMode GeneCounts 
 

#calculate FPKM for each gene and transcpripts.
stringtie -e -B  -G $gtf -p 16 -A ./ballgown/$newname.tab  -o ./ballgwon/$newname/$newname.gtf ./star_out/$newname.Aligned.sortedByCoord.out.bam
done

