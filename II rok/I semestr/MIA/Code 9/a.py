def main():
    n, m = [int(x) for x in input().split()]

    def wczytajJiro():
        defs = [0]*n
        atks = [0]*n
        both = [0]*2*n
        defi = atki = bothi = 0
        for i in range(n):
            pi, si = input().split()
            if (pi == 'ATK'):
                atks[atki] = int(si)
                atki += 1
                both[bothi] = int(si)
                bothi += 1
            else:
                defs[defi] = int(si)
                defi += 1
                both[bothi] = int(si) + 1
                bothi += 1
        return (sorted(defs[:defi]), sorted(atks[:atki]), sorted(both[:bothi]))
    def wczytajCiel():
        ms = [0]*m
        for i in range(m):
            si = int(input())
            ms[i] = si
        return sorted(ms)

    jiro = wczytajJiro()
    defenses, attacks, both = jiro
    ciel = wczytajCiel()


    def czyZabijamyWszyskie():
        zzamkowane = zip(reversed(ciel), reversed(both))
        checked = map(lambda cj : cj[0] - cj[1] >= 0, zzamkowane)
        return all(checked)
    def f(cj):
        c, j = cj
        r = c - j
        if (r >= 0):
            return r
        else:
            return 0
    def bezNajslabszychObroncow():
        w = 0
        wyniklen = len(ciel)
        for d in defenses:
            while w != wyniklen and ciel[w] <= d:
                w += 1
            if w == wyniklen:
                break
            ciel[w] = 0
        return sum(ciel)

    if czyZabijamyWszyskie():
        w = sum(map(f, zip(reversed(ciel), attacks)))
        w1 = bezNajslabszychObroncow()
        w2 = sum(attacks)
        print(max(w, w1 - w2))
    else:
        w = sum(map(f, zip(reversed(ciel), attacks)))
        print(w)


main()
