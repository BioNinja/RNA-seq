#! bin/bash
#building index
#hisat2-build -f ~/Downloads/hg19/hg19.fasta  -p 12  ~/Genome/hisat_index/hg19
#hisat2_extract_splice_sites.py ../hg19/Homo_sapiens.Ensembl.GRCh37.75.gtf > splicesites.txt
#hisat2_extract_exons.py ../hg19/Homo_sapiens.Ensembl.GRCh37.75.gtf > exon.txt

#mapping to reference genome
sample=(NC C20_2 C20_3)
for var in ${sample[@]}
    do
        hisat2 -p 12 --dta -x ~/Genome/hisat_index/hg19  -1 /Users/bioninja/zll/fastq/Cleandata/${var}/${var}_1.fq.gz -2 /Users/bioninja/zll/fastq/Cleandata/${var}/${var}_2.fq.gz --known-splicesite-infile ~/Genome/hisat_index/splicesites.txt  -S ./hisat_out/${var}.sam   -t
done

#running stringtie
for var in ${sample[@]}
    do
        #samtools view -bS ./hisat_out/${var}.sam > ./hisat_out/${var}.bam
        samtools view -bS ./hisat_out/${var}.sam | samtools sort -T ./hisat_out/${var} -o ./hisat_out/${var}.sorted.bam
        #samtools sort -T  ./hisat_out/${var} -o ./hisat_out/${var}.sorted.bam ./hisat_out/${var}.bam 
        samtools index ./hisat_out/${var}.sorted.bam
        stringtie -e -b ./stringtie_out/${var}_strg -G ~/Genome/hg19/Homo_sapiens.Ensembl.GRCh37.75.gtf -p 12 -o ./stringtie_out/${var}.gff ./hisat_out/${var}.sorted.bam 
done

for var in ${sample[@]}
do
    htseq-count -r pos -s no -f bam ./hisat_out/${var}.sorted.bam ~/Genome/hg19/Homo_sapiens.Ensembl.GRCh37.75.gtf > ./htseq_out/${var}.count
done

