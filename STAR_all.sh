#!bin/bash

sample=(2D0 2D5 2D5N 2D10 2D10N 2D20R 2D25 8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
for var in ${sample[@]} 
     do 
         STAR --genomeDir ~/project-yxing/genome/STAR_hg19_GRCh37.75_length_100/ --readFilesIn ../raw_data/${var}_1.fq ../raw_data/${var}_2.fq --outSAMunmapped Within --outFilterType BySJout --outSAMattributes NH HI AS NM MD --outFilterMultimapNmax 20 --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --runThreadN 16 --outSAMtype BAM Unsorted --genomeLoad LoadAndKeep --quantMode TranscriptomeSAM --outFileNamePrefix ./${var}_

done
