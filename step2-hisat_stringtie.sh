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

set -e
#hisat2-build -f ~/genome/hg19/hg19.fa  -p 16  ~/genome/hisatIndex_hg19/hg19
#hisat2_extract_splice_sites.py ~/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf > ~/genome/hisatIndex_hg19/splicesites.txt
#hisat2_extract_exons.py ~/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf > ~/genome/hisatIndex_hg19/exon.txt

#mapping to reference genome
#find . -name "*trim.fq.gz" | while read id; do echo ${id%%_R*}; done | sort -k1,1 | uniq > file_name_prefix.txt

#sample=(./M/Sample_M_20160419_CGTACG_L006 ./M/Sample_M_20160301_ATGTCA_L003 ./M-T/Sample_M_T_20160301_AGTTCC_L003 ./M-T/Sample_M_T_20160419_GTTTCG_L006 ./T/Sample_T2_20160301_GTCCGC_L003 ./T/Sample_T1_20160301_CCGTCC_L003 ./T/Sample_T3_20160301_GTGAAA_L003)

gtf=~/genome/gtf_human/gencode.v19.annotation.gtf
genome=/picb/external/isotex/genome/hisat2Index_hg19 
suffix="fastq.gz"


mkdir -p hisat_out
mkdir -p ballgown
ls ./rawdata/*fastq.gz | while read id; do echo ${id%%_R*}; done | sort -k1,1 | uniq | while read var; 
    do
        hisat2 -p 16 --dta -x $genome/hg19  -1 ${var}_R1.${suffix} -2 ${var}_R2.${suffix}  --known-splicesite-infile $genome/splicesites.txt  -S ./hisat_out/${var##*/}.sam   -t 2> ./hisat_out/${var##*/}.align.log
        #samtools view -bS ./hisat_out/${var}.sam > ./hisat_out/${var}.bam
        samtools view -@ 16 -bS ./hisat_out/${var##*/}.sam | samtools sort -@ 16  -T ./hisat_out/${var##*/} -o ./hisat_out/${var##*/}.sorted.bam
        #samtools sort -T  ./hisat_out/${var} -o ./hisat_out/${var}.sorted.bam ./hisat_out/${var}.bam 
        samtools index ./hisat_out/${var##*/}.sorted.bam
        stringtie -e -A ./ballgown/${var##*/}.tab  -B -G $gtf -p 16 -o ./ballgown/${var##*/}/${var##*/}.gtf  ./hisat_out/${var##*/}.sorted.bam
        rm ./hisat_out/${var##*/}.sam 
done



