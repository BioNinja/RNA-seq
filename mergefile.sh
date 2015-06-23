#!/bin/bash

sample=(2D5 2D5N 2D10 2D10N 2D20R 2D25 8D0 8D5 8D5N 8D10 8D10N 8D20R 8D25)
cut -f 1,2 ../2D0.genes.results > resm_fpkm.txt
for i in ${sample[@]}
    do
       cut -f 7 ../${i}.genes.results> ${i}.genes.cut
       paste -s resm_fpkm.txt ${i}.genes.cut
done
