#!/usr/bin/env python
# coding: utf-8

# In[6]:


# Arxiv: https://arxiv.org/
import arxiv
import csv

results = []
searchterms = ['cross-border',
             'Common Market Law Review',
             'cross-border merger',
             'cross-border conversion',
             'cross-border division',
             'company law package']

for item in searchterms:
    result = arxiv.query(query=item, max_results=100)
    for paper in result:
        if ('cs' in paper['arxiv_primary_category']['term']):
            currentresult = []
            currentresult.append(item)
            currentresult.append(paper['id'])
            currentresult.append(paper['title'])
            currentresult.append(paper['summary'])
            currentresult.append(paper['journal_reference'])

            results.append(currentresult)
        
with open('Arxiv_results_GK.csv', 'w', newline='') as writeFile:
    writer = csv.writer(writeFile)
    writer.writerows(results)


# In[ ]:




