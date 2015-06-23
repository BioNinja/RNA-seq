#!/bin/bash
esc8=(8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
esc2=(2D5 2D5N 2D10 2D10N 2D20R 2D25)
sample=(2D5 2D5N 2D10 2D10N 2D20R 2D25 8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
for var in ${esc8[@]} 
     do 
      samtools view  -b -S ../${var}_Aligned.out.sam > ../bam_files/${var}_Aligned.bam

done
