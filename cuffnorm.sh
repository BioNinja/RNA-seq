#!bin/bash

# I know the original 2D20R fastq file was mistake with 2D10N, please note the time point order below.
# Because I don't want to find new transcripts,I used gtf file which was used to building genome.
# Usually, new transcipts has not annotation,so we just calculate what we have known.


qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffnorm -p 16 -o ./cuffnorm_out/SHhESC2 -L 2D0,2D5N,2D10N_Yes,2D20R_Yes,2D25,2D5,2D10  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/2D0/abundances.cxb ./cuffquant_out/2D5N/abundances.cxb ./cuffquant_out/2D20R/abundances.cxb ./cuffquant_out/2D10N/abundances.cxb ./cuffquant_out/2D25/abundances.cxb ./cuffquant_out/2D5/abundances.cxb ./cuffquant_out/2D10/abundances.cxb


qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffnorm -p 16 -o ./cuffnorm_out/SHhESC8 -L 8D0,8D5N,8D10N,8D20R,8D25,8D5,8D10  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/8D0/abundances.cxb ./cuffquant_out/8D5N/abundances.cxb ./cuffquant_out/8D10N/abundances.cxb ./cuffquant_out/8D20R/abundances.cxb ./cuffquant_out/8D25/abundances.cxb ./cuffquant_out/8D5/abundances.cxb ./cuffquant_out/8D10/abundances.cxb





