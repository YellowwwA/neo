#!usr/bin/env python

import prime_func

while(1):
    a = int(input("Input number(0 : Quit) : "))
    if a == 0:
        break
    if a<2:
        print("re-enter number~!!")
        continue
    else:
        if prime_func.is_prime(a):
            print(f'{a} is prime number')
        else:
             print(f'{a} is not prime number')

