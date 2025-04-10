#!usr/bin/env python

import random

class BinaryDigits:
    def __init__(self, num, lists):
        self.num = num
        self.lists = lists
    def convert(self):
        q = self.num
        while (q != 0):
            r = q % 2
            q = q // 2
            lists.append(r)
        lists.reverse()
        return lists

lists = []
num = random.randrange(4, 20)
bin = BinaryDigits(num, lists)
print(f'{num} binary number is : {bin.convert()}')

