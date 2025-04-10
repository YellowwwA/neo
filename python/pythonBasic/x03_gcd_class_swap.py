#!usr/bin/env python

import random

class GCD(object):
    def __init__(self, a, b):
        self.a = a
        self.b = b
    def gcd(self):
        if self.a < self.b:
            self.a, self.b = self.b, self.a
        while(self.b != 0):
            r = self.a % self.b
            self.a = self.b
            self.b = r
        return self.a

a = int(input("Input First number : "))
b = int(input("Input Second number : "))

print("gcd(",a,b,")")
data1 = GCD(a,b)
print(f'gcd({a,b}) of {a}, {b} = {data1.gcd()}')