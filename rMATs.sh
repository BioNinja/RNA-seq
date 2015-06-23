#!bin/bash

qsub -pe shared 4 -l h_data=4G,h_rt=30:00:00,highp ~/data/rMATs.sh python /u/home/z/zqfang/project-yxing/program/rMATS.3.0.9/RNASeq-MATS.py -b1 ../STAR_out_for_all/2D0_Aligned.out.bam -b2 ../STAR_out_for_all/2D5_Aligned.out.bam -gtf /u/home/z/zqfang/project-yxing/program/rMATS.3.0.9/gtf/Homo_sapiens.Ensembl.GRCh37.72.gtf -o /u/home/z/zqfang/project-yxing/STAR_neural_diff/STAR_rMATs/2D0_vs_2D5/ -t paired -len 100 

qsub -pe shared 4 -l h_data=4G,h_rt=30:00:00,highp ~/data/rMATs.sh python /u/home/z/zqfang/project-yxing/program/rMATS.3.0.9/RNASeq-MATS.py -b1 ../STAR_out_for_all/8D0_Aligned.out.bam -b2 ../STAR_out_for_all/8D5_Aligned.out.bam -gtf /u/home/z/zqfang/project-yxing/program/rMATS.3.0.9/gtf/Homo_sapiens.Ensembl.GRCh37.72.gtf -o /u/home/z/zqfang/project-yxing/STAR_neural_diff/STAR_rMATs/8D0_vs_8D5/ -t paired -len 100 



