pobierz = lambda : list(map(int, input().split()))
def main():
    [n] = pobierz()
    x1, x2 = pobierz()

    def liczYs(ai, bi):
        prosta = lambda x : ai*x + bi
        return (prosta(x1), prosta(x2))
    lines = [liczYs(*pobierz()) for i in range(n)]

    s1 = sorted(lines)
    s2 = list(map(lambda y1y2 : (y1y2[1], y1y2[0]),sorted(map(lambda y1y2 : (y1y2[1], y1y2[0]), lines))))

    if s1==s2:
        print('NO')
    else:
        print('YES')


main()
