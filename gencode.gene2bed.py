import re, sys
count = 0
outfile = open("test.out.txt","w")
pattern = re.compile(r"\sgene\s")
for line in sys.stdin:
    if line.startswith("#"): continue
    match = pattern.search(line)
    if match:
        count +=1
        outfile.write(line)
print(count)
