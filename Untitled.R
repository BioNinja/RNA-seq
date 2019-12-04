suppressMessages(library("ggplot2"))
suppressMessages(library("RColorBrewer"))
suppressMessages(library("gplots"))
suppressMessages(library("pheatmap"))
suppressMessages(library("DESeq2"))
suppressMessages(library('BiocParallel'))
register(MulticoreParam(threads))
setwd("./public-seq/H170012-P001/trim_results/")
load("./salmon/txi.salmon.RData")
load(txi_image)
#assign each sample to differrent group.
group="Ctrl Ctrl Ctrl HDE HDE HDE"
alias ="SKM-1-Ctrl1 SKM-1-Ctrl2 SKM-1-Ctrl3 SKM-1-HDE1 SKM-1-HDE2 SKM-1-HDE3"
group=unlist(strsplit(group, " "))
alias = unlist(strsplit(alias, " "))
sampleTable <- data.frame(condition = factor(group))
rownames(sampleTable) <- colnames(txi.salmon$counts)

#ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, directory=base_dir, design=~condition)
#rownames(ddsHTSeq) <- gsub('\\.[0-9]+', '', rownames(ddsHTSeq))
## Filter genes with atleast 2 count
#ddsHTSeq <- ddsHTSeq[ rowSums(counts(ddsHTSeq)) > 1,  ]
#colData(ddsHTSeq)$condition<-factor(colData(ddsHTSeq)$condition, levels=c('control','knockdown'))   

#run DESeq2
dds <- DESeqDataSetFromTximport(txi.salmon, sampleTable, ~condition)
dds$condition <- relevel(dds$condition, ref=ugr[1])
dds <- DESeq(dds)

ugr <- unique(group)
group_num <- length(ugr)

for (i in 2:group_num)
{
  #res <- results(dds, contrast=c("condition","treated","control"))
  res <- results(dds, contrast=c("condition", ugr[i], ugr[i-1]))
  resOrdered <- res[order(res$padj),]
  resOrdered = as.data.frame(resOrdered)
  outRES=paste("differential_expression/diff", ugr[i], "vs",ugr[i-1],"results.txt",sep="_")
  write.table(resOrdered, file=outRES, quote=F, sep="\t")
  
  #MA plot
  outMA = paste("differential_expression/diff", ugr[i], "vs", ugr[i-1],"MAplot.pdf",sep="_")
  pdf(outMA, width = 5, height = 5)     
  plotMA(res, ylim=c(-5,5))
  dev.off()
  
  #TopGenes
  betas <- coef(dds)
  topGenes <- head(order(res$padj),20)
  mat <- betas[topGenes, -c(1,2)]
  thr <- 3 
  mat[mat < -thr] <- -thr
  mat[mat > thr] <- thr
  
  outGenes = paste("differential_expression/diff", ugr[i], "vs", ugr[i-1],"top20genes.pdf",sep="_")
  pdf(outGenes, width = 4,height = 3)
  pheatmap(mat, breaks=seq(from=-thr, to=thr, length=101), cluster_col=FALSE)
  dev.off()
  
} 

rld <- rlog(dds, blind = F)
vsd <- varianceStabilizingTransformation(dds)
rlogMat <- assay(rld)
vstMat <- assay(vsd)

#clustering plot
hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100)
distsRL <- dist(t(assay(rld)))
mat <- as.matrix(distsRL)
rownames(mat) <- colnames(mat) <- with(colData(dds), paste(alias))




pdf("differential_expression/Samples.correlation.heatmap.pdf",width = 5, height = 5)
hc <- hclust(distsRL)
heatmap.2(mat, Rowv=as.dendrogram(hc), symm=TRUE, trace="none", 
          col = rev(hmcol), margin=c(13, 13))
dev.off()
colnames(rld) = alias
#PCA plot.
pdf("differential_expression/Samples.PCA.pdf",width = 7.31, height = 5.31)
data <- plotPCA(rld, intgroup="condition", returnData=TRUE)
percentVar <- round(100 * attr(data, "percentVar"))
ggplot(data, aes(PC1, PC2, color=condition, label=rownames(data)))+
  geom_text(check_overlap = T,vjust = 0, nudge_y = 0.5) + geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance"))
dev.off()

# this gives log2(n + 1)
ntd <- normTransform(dds)
ntd2 = t(scale(t(as.matrix(assay(ntd)))))
library("pheatmap")
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:20]
df <- as.data.frame(colData(dds)[,"condition"])
rownames(df) = colnames(rld)
colnames(df) = 'treatment'
outGenes = paste("differential_expression/diff", 'HDE', "vs",'Ctrl',"top20genes.pdf",sep="_")
pdf(outGenes, width = 7.31,height = 5.32)
pheatmap(ntd2[select,], cluster_rows=T, show_rownames=T,
         cluster_cols=T, annotation_col=df)
dev.off()
outGenes = paste("differential_expression/diff", 'HDE', "vs",'Ctrl',"top20genes.pdf",sep="_")
pdf(outGenes, width = 7.31,height = 5.32)
pheatmap(assay(rld)[select,], cluster_rows=T, show_rownames=T,
         cluster_cols=T, annotation_col=df)
dev.off()

#save dds for further processing
save(dds, file="./gene_expression/deseq2.dds.RData")
