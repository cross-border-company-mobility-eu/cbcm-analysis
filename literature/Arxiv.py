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
              'company law package',
              'SE-Directive',
              'SE Directive',
              'cross-border mobility',
              'economical impact of company mobility',
              'Delaware effect',
              'cross-border merger inflation', 'cross-border merger GDP','cross-border merger CPI',
               'cross-border merger wages','cross-border merger market campitalisation',
               'cross-border merger bond yields','cross-border merger transaction costs',
               
               'cross-border inflation', 'cross-border GDP','cross-border CPI','cross-border wages',
               'cross-border market capitalisation','cross-border bond yields','cross-border transaction costs',
               
               'merger and acquisition inflation','merger and acquisition GDP','merger and acquisition CPI',
               'merger and acquisition wages','merger and acquisition market capitalisation',
               'merger and acquisition bond yields','merger and acquisition transaction costs',
               
              'regression analysis',
              "Tobin's Q"]

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




