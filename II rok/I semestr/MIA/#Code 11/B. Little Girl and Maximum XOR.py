import math
def main():
    l, r = [int(x) for x in input().split()]
    xor = l ^ r
    if (xor == 0):
        print(0)
    else:
        print(2 ** (int(math.log(xor, 2)) + 1) - 1)
main()

def main'():
    def MostLeftOne(n):
        i = -1
        while (n > 0):
            n //= 2
            i += 1
        return i

    l, r = [int(x) for x in input().split()]
    xor = l ^ r

    if (xor == 0):
        print(0)
    else:
        print(2 ** (MostLeftOne(xor) + 1) - 1)
