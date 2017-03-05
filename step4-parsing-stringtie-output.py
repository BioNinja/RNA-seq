
# coding: utf-8
#! usr/bin/env python

import pandas as pd
import glob,sys

#file_path= sys.argv[1]
#annotation = sys.argv[2]
annotation = "./gencode.v19.annotation.filtered.all.txt"
filelist = glob.glob("*.tab")


# In[4]:

anno = pd.read_table(annotation)

# In[7]:

frames = []
for f in filelist:
    name = f.split("/")[-1].strip(".tab")
    frame = pd.read_table(f)
    frame.rename(columns={'Coverage': 'Coverage.'+name,'FPKM': 'FPKM.'+name, 'TPM':'TPM.'+name}, inplace=True)
    frames.append(frame)
result = pd.concat(frames, axis=1)





# In[10]:

df = result.loc[:,~result.columns.duplicated()]

# In[16]:

df_merge = anno.merge(df, left_on='gene_id',right_on='Gene ID',how='right')
df_merge.drop(['Gene ID','Gene Name'], axis=1, inplace=True)


# In[21]:

df_merge.to_csv("gene_expression_table_all.csv",index=False)




