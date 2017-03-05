
library("ballgown")

getwd()
setwd("./stringtie_out")

samples = c('S13_D0_A_strg', 'S13_D0_B_strg', 'S13_D2_A_strg', 'S13_D2_B_strg',  'S13_D3_A_strg',  'S13_D3_B_strg' , 'WT_D0_A_strg',  'WT_D0_B_strg',  'WT_D2_A_strg' ,'WT_D2_B_strg', 'WT_D3_A_strg', 'WT_D3_B_strg' )

bg = ballgown(samples = samples, meas='all')



#transcript_fpkm = texpr(bg, 'FPKM')
#transcript_cov = texpr(bg, 'cov')
whole_tx_table = texpr(bg, 'all')
exon_rcount = eexpr(bg, 'rcount')
junction_rcount = iexpr(bg)
#whole_intron_table = iexpr(bg, 'all')
gene_expression = gexpr(bg)



write.csv(whole_tx_table,file='transcripts_expression_table.csv')
write.csv(gene_expression,'gene_expression_table.csv')
write.csv(exon_rcount,"raw_read_count_table.csv")
write.csv(junction_rcount,"junction_read_count_table.csv")
