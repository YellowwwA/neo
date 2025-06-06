#!usr/bin/env python

class Factorial(object):
    def __init__(self, n):
        self.n = n
    def factorial(self):
        n = 1
        for i in range(1, self.n + 1):
            n *= i
        return n

n = int(input("Enter a number: "))
fac = Factorial(n)
print(f'{n}! = {fac.factorial()}')