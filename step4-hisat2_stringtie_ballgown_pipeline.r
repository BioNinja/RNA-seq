
library("ballgown")
setwd("./ballgown/")


samples = c('Blank_combined','U251_combined','U251-DMSO_combined','wmsg-13_combined','wmsh-7_combined','wtca-11_combined','wtdr-11_combined','wtdr-22_combined')
bg = ballgown(samples = samples, meas='all')

#transcript_fpkm = texpr(bg, 'FPKM')
#transcript_cov = texpr(bg, 'cov')
whole_tx_table = texpr(bg, 'all')
exon_rcount = eexpr(bg, 'rcount')
junction_rcount = iexpr(bg)
#whole_intron_table = iexpr(bg, 'all')
gene_expression = gexpr(bg)

write.csv(whole_tx_table,file='./transcripts_expression_table.csv')
write.csv(gene_expression,'gene_expression_table.csv')
#write.csv(exon_rcount,"raw_read_count_table.csv")
write.csv(junction_rcount,"junction_read_count_table.csv")







