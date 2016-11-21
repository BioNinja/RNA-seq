

paste *.count | cut -f 1,2,4,6,8,10,12,14,16 > counts_merge.txt

echo -e "GeneID\tN1_24\tN1_36\tN2_24\tN2_36\tS1_24\tS1_36\tS2_24\tS2_36" > header_all.txt

cat header_all.txt counts_merge.txt | sed '/^__no_feature/,$d' > All_Counts.for.DESeq2.txt
