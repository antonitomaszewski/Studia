def main():
    n = int(input())
    ais = set()
    bis = set()
    wybrane = ['']*n
    w = 0
    wybraneb = set()

    for i in range(n):
        names = input().split()
        ai = names[0][:3]
        bi = ai[:2]+names[1][0]

        if (ai in ais and bi in bis) or (ai in wybraneb and bi in wybrane):
            print('NO')
            return
        if bi in wybrane:
            wybrane[w] = ai
        else:
            wybrane[w] = bi
            wybraneb.add(bi)
        ais.add(ai)
        bis.add(bi)
        w += 1
    print('YES')
    for ab in wybrane:
        print(ab)

main()


def main():
    n = int(input())
    ais = set()
    bis = set()
    wybrane = ['']*n
    w = 0

    for i in range(n):
        names = input().split()
        ai = names[0][:3]
        bi = ai[:2]+names[1][0]

        if bi not in wybrane:
            # bis.add(bi)
            wybrane[w] = bi
        elif ai in ais or ai in wybrane:
            print('NO')
            return
        else:
            # bis.add(ai)
            wybrane[w] = ai
        ais.add(ai)
        w += 1
    print('YES')
    for ab in wybrane:
        print(ab)

main()
