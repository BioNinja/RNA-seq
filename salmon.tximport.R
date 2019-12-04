source("https://bioconductor.org/biocLite.R")
biocLite('tximport')
library(tximport)
library(readr)
sampleInfo <- read.table("../snakeflow/example_sample_info.txt", header=F,sep=" ",stringsAsFactors = F)
tx2gene <- read.table("~/genome/Human_GRCh38/gencode.v26.annotation.extracted.transx2gene.txt", header= T, sep="\t", stringsAsFactors = F)
#tx2gene <- read.table(tx2gene, header= T, sep="\t", stringsAsFactors = F)
samples <-sampleInfo[,1]
#samples <- unlist(strsplit(sample_ids,","))

salmon.files <- file.path('salmon',samples, "quant.sf")
#names(salmon.files) <- sampleInfo[,2]
names(salmon.files) <- samples
all(file.exists(salmon.files))

#aggregate transcripts to genes, and extract raw read counts  
txi.salmon <- tximport(salmon.files, type = "salmon", 
                       tx2gene = tx2gene, reader = read_tsv,
                       countsFromAbundance = "no")
txi.salmon.trans <- tximport(salmon.files, type = "salmon", txOut = TRUE, tx2gene = tx2gene)
salmon.counts<- txi.salmon$counts
salmon.counts<- as.data.frame(salmon.counts)
#salmon.counts$gene_name<- rownames(salmon.counts)
write.table(salmon.counts, out_counts, sep="\t", quote=F)
write.table(salmon.counts, file="counts/sample.raw.counts.txt",sep="\t", quote=F)
salmon.TPM<- txi.salmon$abundance
salmon.TPM<- as.data.frame(salmon.TPM)
#salmon.TPM$gene_name<- rownames(salmon.TPM)
write.table(salmon.TPM, out_tpm, sep="\t", quote=F)
write.table(salmon.TPM,file="./gene_expression/gene_expression.TPM.txt",sep="\t", quote=F)

salmon.trans.TPM <- txi.salmon.trans$abundance
salmon.trans.TPM<- as.data.frame(salmon.trans.TPM)
write.table(salmon.trans.TPM, file="./gene_expression/transcripts_expression.TPM.txt",  sep="\t", quote=F)
#save(txi.salmon, txi.salmon.trans, file=out_image)
save(txi.salmon, txi.salmon.trans, file="salmon/txi.salmon.RData")
