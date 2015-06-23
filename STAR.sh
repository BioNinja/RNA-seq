#!/bin/bash

sample=(2D0 2D5 2D5N 2D10 2D10N 2D20R 2D25 8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
for var in ${sample[@]}
     do
      STAR --genomeDir ~/project-yxing/genome/STAR_hg19_GRCh37.75_length_100/ --readFilesIn /u/home/z/zqfang/project-yxing/STAR_neural_diff/raw_data/${var}_1.fq /u/home/z/zqfang/project-yxing/STAR_neural_diff/raw_data/${var}_2.fq --outSAMstrandField intronMotif --alignEndsType EndToEnd  --runThreadN 16 --genomeLoad LoadAndKeep --outFileNamePrefix /u/home/z/zqfang/project-yxing/STAR_neural_diff/STAR_out_for_all/${var}_
done
