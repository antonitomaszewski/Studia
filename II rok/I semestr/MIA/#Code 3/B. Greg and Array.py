pobierz = lambda : map(int, input().split())
def main():
    n, m, k = pobierz()
    ans = pobierz()

    operations = list(map(lambda lrd : (lrd[0]-1, lrd[1], lrd[2]), [list(pobierz()) for i in range(m)]))
    queries = list(map(lambda xy : (xy[0]-1, xy[1]), [list(pobierz()) for i in range(k)]))

    ileKazdejOperacji = [0] * (m+1)
    for (xi, yi) in queries:
        ileKazdejOperacji[xi] += 1
        ileKazdejOperacji[yi] -= 1
    for i in range(1, m+1):
        ileKazdejOperacji[i] += ileKazdejOperacji[i-1]

    ileZmienic = [0] * (n+1)
    for i, (li, ri, di) in enumerate(operations):
        roznica = ileKazdejOperacji[i] * di
        ileZmienic[li] += roznica
        ileZmienic[ri] -= roznica
    for i in range(1, n+1):
        ileZmienic[i] += ileZmienic[i-1]

    s = ''
    for i, ai in enumerate(ans):
        s += str(ai + ileZmienic[i]) + ' '
    print(s)

main()
