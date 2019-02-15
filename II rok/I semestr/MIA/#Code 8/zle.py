from math import inf
pobierz = lambda : list(map(int, input().split()))

def main():
    # n = int(input())
    # dist = [pobierz() for _ in range(n)]
    # xs = list(map(lambda xi : xi-1, pobierz()))
    n,dist,xs = wczytaj()
    vertices = [vi for vi in range(n)]
    res = ""
    for xi in reversed(xs):
        # dożucenie xi do zbioru i wypełnienie jego sąsiadów
        # for vi in V:
        #     dist[vi][xi] = macierz[vi][xi]
        #     dist[xi][vi] = macierz[xi][vi]
        # # obliczam minimalne drogi z xi do dowolnego vi oraz z dowolnego vi do xi
        # for vi in V:
        #     dxv = dist[xi][vi]
        #     dvx = dist[vi][xi]
        #     for ui in V:
        #         dxu = dist[xi][ui]
        #         duv = dist[ui][vi]
        #         dist[xi][vi] = min(dxv, dxu+duv)
        #
        #         dvu = dist[vi][ui]
        #         dux = dist[ui][xi]
        #         dist[vi][xi] = min(dvx, dvu+dux)
        #
        #
        # # teraz gdy xi jest już zoptymalizowany, optymalizujemy całą resztę, czyli dla dowolnej pary vi ui sprawdzamy czy po przejściu przez xi będzie lepiej
        # for vi in V:
        #     for ui in V:
        #         dvu = dist[vi][ui]
        #         dvx = dist[vi][xi]
        #         dxu = dist[xi][ui]
        #         dist[vi][ui] = min(dvu, dvx+dxu)
        #         if (dvu == inf):
        #             print(dvu + ' vi=' + vi + ' ui=' + ui)
        #         if (dvx + dxu == inf):
        #             print(dvx+dxu + ' vi=' + vi + ' xi=' + xi + ' ui=' + ui)

        for vi in V:
            for ui in V:
                macierz[vi][ui] = min(macierz[vi][ui], macierz[vi][xi]+macierz[xi][ui])

        # print(dist)
        V.add(xi)
        s = 0
        for vi in V:
            for ui in V:
                s += macierz[vi][ui]
        res += str(s) + " "
        print(s)
    print(" ".join(list(reversed(res.split()))))

main()


def wczytaj():
    i = pobierz()
    n = i[0]
    macierz = [i[1+n*j:n*(j+1)+1] for j in range(n)]
    koniec = i[len(i)-n:len(i)]
    koniec = list(map(lambda xi : xi-1, koniec))
    return n,macierz,koniec
