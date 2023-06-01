#!/usr/bin/env python
# coding: utf-8

# In[13]:


name=input()


# In[23]:


weight=int(input('enter your weight in pounds: '))
height=int(input('enter your height in inches: '))

BMI = (weight*703) / (height*height)

print(BMI)

if BMI>0:
    if (BMI<18.5):
        print (name+', you are underweight.')
    elif (BMI<=24.9):
        print (name+', you are normal weight.')
    elif (BMI<=29.9):
        print (name+', you are overweight.')
    elif (BMI<=34.9):
        print (name+', you are obese.')
    elif (BMI<=39.9):
        print (name+', you are severely obese.')
    else:
        print (name+', you are morbidly obese.')
else:
    print:('enter valid input')


# In[ ]:


#
Under 18.5	Underweight	Minimal
18.5 - 24.9	Normal Weight	Minimal
25 - 29.9	Overweight	Increased
30 - 34.9	Obese	High
35 - 39.9	Severely Obese	Very High
40 and over	Morbidly Obese	Extremely High


# In[ ]:


#BMI = (weight in pounds x 703) / (height in inches x height in inches)

