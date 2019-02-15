def almost(n):
    p = 2
    ile = 0
    while (n > 1):
        if (n % p == 0):
            if (ile == 2):
                return False
            while (n % p == 0):
                n /= p
            ile += 1
        p += 1
    return (ile == 2)

def main():
    n = int(input())
    ile = 0
    while (n > 0):
        if (almost(n)):
            ile += 1
        n -= 1
    print(ile)

main()
