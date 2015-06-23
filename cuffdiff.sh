#!bin/bash

# I know the original 2D20R fastq file was mistake with 2D10N, please note the time point order below.

qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffdiff -p 16 -o ./cuffdiff_out/SHhESC2 -b /u/home/z/zqfang/project-yxing/genome/STAR_hg19_GRCh37.75_length_100 -T -L 2D0,2D5N,2D10N_Yes,2D20R_Yes,2D25,2D5,2D10 -u  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/2D0/abundances.cxb ./cuffquant_out/2D5N/abundances.cxb ./cuffquant_out/2D20R/abundances.cxb ./cuffquant_out/2D10N/abundances.cxb ./cuffquant_out/2D25/abundances.cxb ./cuffquant_out/2D5/abundances.cxb ./cuffquant_out/2D10/abundances.cxb


qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffdiff -p 16 -o ./cuffdiff_out/SHhESC8 -b /u/home/z/zqfang/project-yxing/genome/STAR_hg19_GRCh37.75_length_100 -T -L 8D0,8D5N,8D10N,8D20R,8D25,8D5,8D10 -u  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/8D0/abundances.cxb ./cuffquant_out/8D5N/abundances.cxb ./cuffquant_out/8D10N/abundances.cxb ./cuffquant_out/8D20R/abundances.cxb ./cuffquant_out/8D25/abundances.cxb ./cuffquant_out/8D5/abundances.cxb ./cuffquant_out/8D10/abundances.cxb

qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffdiff -p 16 -o ./cuffdiff_out/8D5N_vs_8D5 -b /u/home/z/zqfang/project-yxing/genome/STAR_hg19_GRCh37.75_length_100 -L 8D5N,8D5 -u  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/8D5N/abundances.cxb ./cuffquant_out/8D5/abundances.cxb

qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffdiff -p 8 -o ./cuffdiff_out/8D10N_vs_8D10 -b /u/home/z/zqfang/project-yxing/genome/STAR_hg19_GRCh37.75_length_100 -L 8D10N,8D10 -u  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/8D10N/abundances.cxb ./cuffquant_out/8D10/abundances.cxb


qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffdiff -p 16 -o ./cuffdiff_out/2D5N_vs_2D5 -b /u/home/z/zqfang/project-yxing/genome/STAR_hg19_GRCh37.75_length_100 -L 2D5N,2D5 -u  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/2D5N/abundances.cxb ./cuffquant_out/2D5/abundances.cxb

qsub -pe shared 4 -l h_data=4G,h_rt=24:00:00,highp ~/data/cuffdiff.sh  cuffdiff -p 8 -o ./cuffdiff_out/2D10N_vs_2D10 -b /u/home/z/zqfang/project-yxing/genome/STAR_hg19_GRCh37.75_length_100 -L 2D10N,2D10 -u  /u/home/z/zqfang/project-yxing/genome/gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf  ./cuffquant_out/2D20R/abundances.cxb ./cuffquant_out/2D10/abundances.cxb
