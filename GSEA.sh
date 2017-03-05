#running GSEA in command line
java -cp $HOME/program/gsea2-2.2.1.jar -Xmx5000m xtools.gsea.Gsea -dir test -res test.gct -cls test.cls -gmx test.gmx -collapse false 


java -Xmx2048m xtools.gsea.Gsea 
-res \\Krypton\GSEATest\DataSets\P53_hgu95av2.gct 
-cls \\Krypton\GSEATest\DataSets\P53.cls#MUT_versus_WT 
-gmx ftp.broadinstitute.org://pub/gsea/gene_sets/c1.v2.symbols.gmt 
-chip ftp.broadinstitute.org://pub/gsea/annotations/HG_U95Av2.chip 
-collapse false -mode Max_probe -norm meandiv -nperm 1000 -permute gene_set 
-rnd_type no_balance -scoring_scheme weighted -rpt_label my_analysis 
-metric log2_ratio_of_diff -sort real -order descending -include_only_symbols true 
-make_sets true -median false -num 100 -plot_top_x 20 -rnd_seed timestamp 
-save_rnd_lists false -set_max 3000 -set_min 15 -zip_report false 
-out C:\Program Files\gsea_home\dec18 -gui false

