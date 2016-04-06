# Often it is hard to see where you have datain IGV
# We have to zoom in to see it. It is handy to build
# a file that shows the coverage (bedgraph).

sample=(NC C20_2 C20_3)

for var in ${sample[@]}
do
#if warning message is something like " *bedgraph is not case-sensitive sorted at line 43104469"
#"Please use sort -k1,1 -k2,2n with LC_COLLATE=C,  or bedSort and try again"
#using the command below will fix the problem.

bedtools genomecov -ibam hisat_out/${var}.sorted.bam -g ~/Genome/hg19/hg19.chrom.size.txt -split -bg | LC_COLLATE=C sort -k1,1 -k2,2n  > hisat_out/${var}.sorted.bedgraph
done

# Bedgraph is inefficient for large files.
# What we typically use are so called bigWig files that are built to load much faster.
for var in ${sample[@]}
do
bedGraphToBigWig hisat_out/${var}.sorted.bedgraph ~/Genome/hg19/hg19.chrom.size.txt  hisat_out/${var}.bw
done

