#!usr/bin/env python

import random

data = random.sample(range(1,101), 10)
max = 0
for i in range(10):
    if(data[i]>max):
        max = data[i]
print(data)
print("max value is : ", max)

