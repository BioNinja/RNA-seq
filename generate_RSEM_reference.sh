# extract exons from gtf file, if you want only exons!
# awk '$3 == "exon"' gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf > gtf/Homo_sapiens.Ensembl.GRCh37.75.exons.gtf

#prepare a reference transcriptome against which to align reads,STAR users do not want to have ployA
mkdir rsemGenome
rsem-prepare-reference --no-polyA --no-bowtie --gtf gtf/Homo_sapiens.Ensembl.GRCh37.75.gtf ./hg19/hg19.fa RSEMtr_hg19
