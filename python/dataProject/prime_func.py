def is_prime(a):
    for i in range(2,a):
        if (a % i) == 0:
            return 0
    return 1



