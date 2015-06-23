#!/bin/bash

sample=(2D0 2D5 2D5N 2D10 2D10N 2D20R 2D25 8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
for var in ${sample[@]} 
     do 
          qsub -pe shared 4 -l h_data=4G,h_rt=16:00:00,highp ~/data/rsem_star_cal_exp.sh  rsem-calculate-expression -p 12 --bam --paired-end --no-bam-output --forward-prob 0.5  ../STAR_out_for_all/${var}_Aligned.toTranscriptome.out.bam  /u/home/z/zqfang/project-yxing/genome/RSEM_transcriptome_hg19_GRCh37.75/rsem_hg19 ./${var}

done
