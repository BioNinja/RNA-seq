import glob,os

es2="2D0 2D5N 2D10N 2D20R 2D25"
es8="8D0 8D5N 8D10N 8D20R 8D25"
rep_name="D0 D5N D10N D20R D25".split()

es2_all = es2+" 2D5 2D10"
es8_all = es8+" 8D5 8D10"

es2_bampath = ["mapped/"+item+".sorted.bam" for item in es2.split()]
es8_bampath = ["mapped/"+item+".sorted.bam" for item in es8.split()]

es2_all_bampath = ["mapped/"+item+".sorted.bam" for item in es2_all.split()]
es8_all_bampath = ["mapped/"+item+".sorted.bam" for item in es8_all.split()]

RMATS_DIR="/Users/bioninja/program/rMATS.3.2.5/RNASeq-MATS.py"
# gtf
GENOME = "/Users/bioninja/genome"
GTF_FILE =       GENOME+"/gtf/gencode.v19.annotation.gtf"

READ_LEN = 100


gtf=GTF_FILE

# params:
es2_b1=",".join(es2_all_bampath)
es8_b1=",".join(es8_all_bampath)
rmats=RMATS_DIR

#prefix="alternative_splicing/{sample1}_vs_{sample2}".format(sample1='GROUP1', sample2='GROUP2')

#cmd ="python %s -b1 %s -b2 %s -gtf %s -o %s"%(rmats, es2_b1, es8_b1, gtf, prefix)
extra=" -t paried -len %s -a 1 -c 0.0001 -analysis U -novelSS 0"%READ_LEN

b_rep = [e2+","+e8 for e2, e8 in zip(es2_bampath,es8_bampath)]

outfile = open("rmats.run.neural.diff.sh", "w") 

prefix="alternative_splicing/es2_only"
cmd ="python %s -b1 %s -b2 %s -gtf %s -o %s -lite"%(rmats, es2_b1, "" , gtf, prefix)
cmd += extra
print(cmd+"\n")
outfile.write(cmd+"\n")


prefix="alternative_splicing/es8_only"
cmd ="python %s -b1 %s -b2 %s -gtf %s -o %s -lite"%(rmats, es8_b1, "" , gtf, prefix)
cmd += extra
print(cmd+"\n")
outfile.write(cmd+"\n")


for i in range(1,len(b_rep)):
    prefix="alternative_splicing/{sample1}_vs_{sample2}".format(sample1=rep_name[i-1], sample2=rep_name[i])
    cmd ="python %s -b1 %s -b2 %s -gtf %s -o %s "%(rmats, b_rep[i-1], b_rep[i], gtf, prefix)
    cmd +=extra
    print(cmd+"\n")
    outfile.write(cmd+'\n')


outfile.close()






