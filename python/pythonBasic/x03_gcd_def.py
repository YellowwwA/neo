#!usr/bin/env python

import random

def gcd(a,b):
    while(b != 0):
        r = a % b
        a = b
        b = r
    return a

a = int(input("Input First number : "))
b = int(input("Input Second number : "))

print("gcd(",a,b,")")
print(f'gcd({a,b}) of {a}, {b} = {gcd(a,b)}')