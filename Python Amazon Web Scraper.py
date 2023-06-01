#!/usr/bin/env python
# coding: utf-8

# # import libraries 

# In[1]:


from bs4 import BeautifulSoup
import requests
import time
import datetime

import smtplib


# # connect to website and import data

# In[2]:


page = requests.get(url='https://www.amazon.com/gp/product/B07C56YJ5C/ref=ox_sc_act_title_1?smid=A2WWXY40F3ZPT8&psc=1', headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36", "Accept-Language": "en-US,en;q=0.9", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml, application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"})
page.raise_for_status()

data = page.text

print(data)
soup1 = BeautifulSoup(data, "html.parser")
soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

title = soup1.find(id='productTitle').get_text()

price_dollar = soup1.find(name="span", class_="a-price-whole").getText()
price_cents = soup1.find(name="span", class_="a-price-fraction").getText()
total_price = (float(f"{price_dollar}{price_cents}"))

print(title)
print(total_price)


# In[3]:


print(title)
print(total_price)


# # clean data

# In[4]:


title2=title.strip()
print(title2)
print(total_price)


# # create timestamp to track when data was collected
# 

# In[5]:


import datetime

today = datetime.date.today()

print(title2)
print(total_price)
print(today)


# # create CSV w headers and write data to the file
# 

# In[8]:


import csv 

header = ['Title', 'Price', 'Date']
data = [title2, total_price, today]


with open('AmazonWebScraperDataset.csv', 'w', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(header)
    writer.writerow(data)


# In[9]:


import pandas as pandas

df = pandas.read_csv(r'C:\Users\julie\AmazonWebScraperDataset.csv')

print(df)


# # append data in csv
# 

# In[10]:


with open('AmazonWebScraperDataset.csv', 'a+', newline='', encoding='UTF8') as f:
    writer = csv.writer(f)
    writer.writerow(data)

import pandas as pandas
df = pandas.read_csv(r'C:\Users\julie\AmazonWebScraperDataset.csv')
print(df)


# # combined function
# 

# In[11]:


def check_price():
    from bs4 import BeautifulSoup
    import requests
    import time
    import datetime

    import smtplib
    page = requests.get(url='https://www.amazon.com/gp/product/B07C56YJ5C/ref=ox_sc_act_title_1?smid=A2WWXY40F3ZPT8&psc=1', 
    headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36", "Accept-Language": "en-US,en;q=0.9", "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml, application/xml;q=0.9,*/*;q=0.8", "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"})
    page.raise_for_status()

    data = page.text

    # Adding this print will fix the issue for consecutive days.
 
    print(data)
    soup1 = BeautifulSoup(data, "html.parser")
    soup2 = BeautifulSoup(soup1.prettify(), "html.parser")

    title = soup1.find(id='productTitle').get_text()
    title2=title.strip()

    price_dollar = soup1.find(name="span", class_="a-price-whole").getText()
    price_cents = soup1.find(name="span", class_="a-price-fraction").getText()
    total_price = (float(f"{price_dollar}{price_cents}"))
    
    import datetime
    today = datetime.date.today()
    
    import csv 
    header = ['Title', 'Price', 'Date']
    data = [title2, total_price, today]
    
    with open('AmazonWebScraperDataset.csv', 'a+', newline='', encoding='UTF8') as f:
        writer = csv.writer(f)
        writer.writerow(data)


# In[12]:


import pandas as pandas

df = pandas.read_csv(r'C:\Users\julie\AmazonWebScraperDataset.csv')

print(df)


# # run check_price per set time & populate CSV

# In[ ]:


while(True):
    check_price()
    time.sleep(604800)


# In[1]:


import pandas as pandas

df = pandas.read_csv(r'C:\Users\julie\AmazonWebScraperDataset.csv')

print(df)


# # send email when a price falls in range
# 

# In[ ]:


def send_mail():
    server = smtplib.SMTP_SSL('smtp.gmail.com',465)
    server.ehlo()
    #server.starttls()
    server.ehlo()
    server.login('jules.horton.work@gmail.com','xxxxxxxxxxxxxx')
    
    subject = "The Kitten Felting Kit you want is below $15! Now is your chance to buy!"
    body = "Jules, This is the moment we have been waiting for. Now is your chance to pick up the Felting Kit of your dreams. Don't mess it up! 
    Link here: 'https://www.amazon.com/gp/product/B07C56YJ5C/ref=ox_sc_act_title_1?smid=A2WWXY40F3ZPT8&psc=1'  
    msg = f"Subject: {subject}\n\n{body}"
    
    server.sendmail(
        'jules.horton.work@gmail.com@gmail.com',
        msg
     
    )

