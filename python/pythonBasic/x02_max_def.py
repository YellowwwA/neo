#!usr/bin/env python

import random

data = random.sample(range(1,101), 10)

def findMax(data):
    max = 0
    for i in range(data.__len__()):
        if(data[i]>max):
            max = data[i]
    return max
print(data)
print("max value is : ", findMax(data))
