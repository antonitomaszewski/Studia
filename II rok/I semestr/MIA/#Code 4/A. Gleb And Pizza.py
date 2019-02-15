pobierz = lambda : list(map(int, input().split()))
def main():
    r, d = pobierz()
    [n] = pobierz()

    l = r-d

    def isTasty(xi, yi, ri):
        dist = lambda xi, yi : pow(xi**2 + yi**2, .5)
        di = dist(xi, yi)
        dl = di-ri
        dr = di+ri
        return dl >= l and dr <= r

    print(sum(map(lambda xyr : isTasty(*xyr), [pobierz() for i in range(n)])))

main()
