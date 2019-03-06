from random import randint, choice
from time import time
transpozycja = lambda xss : list(map(list, zip(*xss)))
def opt_dist(xs, D):
    ones = sum(xs)
    maximum = sum(xs[0:D])
    obecny = maximum
    for i in range(1, len(xs)-D+1):
        obecny += xs[i+D-1] - xs[i-1]
        maximum = max(maximum, obecny)
    toAdd = D - maximum
    toRemove = ones - maximum
    return toAdd + toRemove

def printZagadka(xss):
    for xs in xss:
        for x in xs:
            if x:
                print('|', end='')
            else:
                print('|', end='')
        print('\n')
    print('\n')

def solve(ys, xs):
    good = lambda : not(sum(xstan.values()) + sum(ystan.values()))
    def refresh():
        macierz = [[randint(0,1) for _ in xs] for _ in ys]
        transponowana = transpozycja(macierz)
        ystan = {i : opt_dist(macierz[i], ys[i]) for i in range(n)}
        xstan = {j : opt_dist(transponowana[j], xs[j]) for j in range(m)}
        return macierz, ystan, xstan
    n = len(ys)
    m = len(xs)
    srednia = (n+m)//2
    macierz, ystan, xstan = refresh()

    xprzedzial = [i for i in range(m)]
    yprzedzial = [j for j in range(n)]
    st_ = time()

    def funkcja(row, column, ir, jc, poprzy, poprzx):
        row[jc]^=1
        column[ir]^=1
        rowstan = opt_dist(row, ys[ir])
        columnstan = opt_dist(column, xs[jc])
        # to potrzebne, nie tworzy nowych, więc trzeba zmienić na to co było
        row[jc]^=1
        column[ir]^=1
        return ((poprzy+poprzx)-(rowstan+columnstan), rowstan, columnstan, ir, jc)

    while not(good()) and time() - st_ < 5:
        macierz, ystan, xstan = refresh()
        st = time()
        while sum(ystan.values()) and time()-st < 1:
            if not(randint(0,srednia)):
                i, j = randint(0,n-1), randint(0,m-1)
                macierz[i][j] ^= 1
                transponowana = transpozycja(macierz)
                ystan[i] = opt_dist(macierz[i], ys[i])
                xstan[j] = opt_dist(transponowana[j], xs[j])
            ydo_wyboru = list(filter(lambda i : ystan[i], yprzedzial))
            if not(ydo_wyboru):
                break

            i = choice(ydo_wyboru)
            transponowana = transpozycja(macierz)

            wszystkie = [(macierz[i], transponowana[j], i, j, ystan[i], xstan[j]) for j in range(m)]
            wszystkie = map(lambda w : funkcja(*w), wszystkie)
            best = max(wszystkie, key=lambda x : x[0])
            (wynik, ywynik, xwynik, i, j) = best
            macierz[i][j] ^= 1
            ystan[i] = ywynik
            xstan[j] = xwynik

    return macierz



zValidatora = [ \
    ([7, 7, 7, 7, 7, 7, 7], [7, 7, 7, 7, 7, 7, 7]), \
    ([2, 2, 7, 7, 2, 2, 2], [2, 2, 7, 7, 2, 2, 2]), \
    ([2, 2, 7, 7, 2, 2, 2], [4, 4, 2, 2, 2, 5, 5]), \
    ([7, 6, 5, 4, 3, 2, 1], [1, 2, 3, 4, 5, 6, 7]), \
    ([7, 5, 3, 1, 1, 1, 1], [1, 2, 3, 7, 3, 2, 1])]

for line in zValidatora:
    printZagadka(solve(line[0], line[1]))
