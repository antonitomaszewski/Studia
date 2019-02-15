def main():
    n, m = map(int, input().split())
    pary = [(x,y) for x in range(0,min(n,m) + 1) for y in range(0,min(n,m) + 1)]
    def isgood(a,b):
        return (a*a + b == n) and (a + b*b == m)
    checke = list(filter(lambda ab : isgood(ab[0], ab[1]), pary))
    print(len(checke))

main()
