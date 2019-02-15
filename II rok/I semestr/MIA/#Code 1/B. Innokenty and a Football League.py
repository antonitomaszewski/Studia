def main():
    n = int(input())
    ais = set()
    bis = set()
    wybrane = ['']*n
    w = 0
    wybraneb = set()
    wybraneWszystkie = set()

    for i in range(n):
        names = input().split()
        ai = names[0][:3]
        bi = ai[:2]+names[1][0]

        if (ai in ais and bi in bis) or (ai in wybraneb and bi in wybraneWszystkie):
            print('NO')
            return
        elif bi not in wybraneWszystkie:
            wybrane[w] = bi
            wybraneb.add(bi)
            wybraneWszystkie.add(bi)
        else:
            wybrane[w] = ai
            wybraneWszystkie.add(ai)
        ais.add(ai)
        bis.add(bi)
        w += 1
    print('YES')
    for ab in wybrane:
        print(ab)

main()
