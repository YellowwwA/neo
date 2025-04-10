#!usr/bin/env python

import random

class FindMax(object):
    def __init__(self, data):
        self.data = data
    def max(self):
        max = 0
        for i in range(self.data.__len__()):
            if(self.data[i]>max):
                max = data[i]
        return max

data = random.sample(range(1,101), 10)
print(data)
data1 = FindMax(data)
print("max value is : ", data1.max())
