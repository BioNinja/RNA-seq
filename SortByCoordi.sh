#!/bin/bash

sample=(2D0 2D5 2D5N 2D10 2D10N 2D20R 2D25 8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
for var in ${sample[@]} 
     do 
      qsub -pe shared 4 -l h_data=4G,h_rt=8:00:00,highp ~/data/samtools.sh samtools sort ../bam_files/${var}_Aligned.bam ../bam_files/${var}_Aligned.sorted
done

