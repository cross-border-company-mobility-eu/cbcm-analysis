#!/usr/bin/env python
# coding: utf-8

# ## This is my code

# To scrape google scholar

# In[3]:


# Google Scholar: https://scholar.google.com/
import scholarly
import json
import csv

results = []
searchterms = ['cross-border',
              'cross-border merger']

for item in searchterms:
    search_query = scholarly.search_pubs_query(item)
    for i in range(30):
        paper = next(search_query)
        if ('url' in paper.bib):
            currentresult = []
            currentresult.append(item)
            currentresult.append(paper.bib['url'])
            currentresult.append(paper.bib['title'])
            currentresult.append(paper.bib['abstract'])
            results.append(currentresult)
        
with open('Googlescholar_results.csv', 'w', newline='', encoding='utf-8') as writeFile:
    writer = csv.writer(writeFile)
    writer.writerows(results)


# In[ ]:




