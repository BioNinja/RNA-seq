library(org.Hs.eg.db) #org.Hs.eg.db for mouse
tmp=select(org.Hs.eg.db, keys=as.character(res$id), columns=c("ENTREZID","SYMBOL","GENENAME"), keytype="ENSEMBL")

res=merge(tmp, res,by.x='ENSEMBL',by.y='id',all=TRUE)
#go
tmp=select(org.Hs.eg.db, keys=res$ENSEMBL, columns='GO', keytype='ENSEMBL')
ensembl_go=unlist(tapply(tmp[,2],as.factor(tmp[,1]),function(x) paste(x,collapse ='|'),simplify =F))
#为res加入go注释，
res$go=ensembl_go[res$ENSEMBL]#为res加入一列go
#写入all——data
all_res=res
write.csv(res, file='c20_2vsNC_data.csv',row.names =F)
uniq=na.omit(res)#删除无效基因
sort_uniq=uniq[order(uniq$pval),]#按照矫正p值排序
#写入排序后的all_data
write.csv(res,file='c20_2vsNC_data.csv',row.names =F)
#标记上下调基因
sort_uniq$up_down=ifelse(sort_uniq$baseMeanA>sort_uniq$baseMeanB,'up','down')
#交换上下调基因列位置
final_res=sort_uniq[,c(12,1:11)]
#写出最后数据
write.csv(sort_uniq,file='C20_3_vs_NC_final_annotation_DESeq.csv',row.names =F)
#然后挑选出padj值小于0.1的数据来做富集
tmp=select(org.Hs.eg.db, keys=sort_uniq[sort_uniq$padj<0.1,1], columns='ENTREZID', keytype='ENSEMBL')
#diff_ENTREZID=tmp$ENTREZID
sort_uniq2 = sort_uniq[sort_uniq$padj<0.1,]
diff_ENTREZID = sort_uniq[sort_uniq$log2FoldChange <0,2]
require(DOSE)
require(clusterProfiler)
diff_ENTREZID=na.omit(diff_ENTREZID)
ego <- enrichGO(gene=diff_ENTREZID,organism='human',ont='BP',pvalueCutoff=0.05,readable=TRUE)
ekk <- enrichKEGG(gene=diff_ENTREZID, organism='human',pvalueCutoff=0.05,readable=TRUE, use_internal_data=T)
write.csv(summary(ekk),'C20_2_vs_NC_KEGG-enrich.csv',row.names =F)
write.csv(summary(ego),'C20_3_vs_NC_GO-enrich.csv',row.names =F)
