pobierz = lambda : list(map(int, input().split()))
def wczytaj():
    i = pobierz()
    n = i[0]
    dist = [i[1+n*j:n*(j+1)+1] for j in range(n)]
    koniec = i[len(i)-n:len(i)]
    koniec = list(map(lambda xi : xi-1, koniec))
    return n,dist,koniec

def main():
    n = int(input())
    dist = [pobierz() for _ in range(n)]
    xs = list(map(lambda xi : xi-1, pobierz()))
    # n,dist,xs = wczytaj()
    results = ['' for _ in range(n)]

    for i in range(n):
        i = n-i-1
        xi = xs[i]

        for vi in range(n):
            for ui in range(n):
                dist[vi][ui] = min(dist[vi][ui], dist[vi][xi]+dist[xi][ui])

        s = 0
        for vi in xs[i:]:
            for ui in xs[i:]:
                s += dist[vi][ui]
        results[i] = str(s)
    print(' '.join(results))

main()
