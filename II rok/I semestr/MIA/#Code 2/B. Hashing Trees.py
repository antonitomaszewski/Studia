def main():
    h = int(input())
    ahs = list(map(int, input().split()))

    Ambiguous = list(map(lambda h1h2 : (h1h2[0] > 1) and (h1h2[1] > 1), zip(ahs, ahs[1:])))
    Ambiguous.insert(0, False)
    isPerfect = not(any(Ambiguous))
    if isPerfect:
        print('perfect')
    else:
        czyTrzebaAmbigowac = True
        v = 0
        t1 = ''
        t2 = ''

        for (hi, b) in zip(ahs, Ambiguous):
            t1 += (str(v) + ' ') * hi
            if czyTrzebaAmbigowac and b:
                t2 += str(v-1) + ' '
                t2 += (str(v) + ' ') * (hi - 1)
                czyTrzebaAmbigowac = False
            else:
                t2 += (str(v) + ' ') * hi
            v += hi

        print('ambiguous')
        print(t1)
        print(t2)
main()
