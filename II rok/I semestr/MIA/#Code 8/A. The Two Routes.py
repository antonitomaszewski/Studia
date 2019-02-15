from collections import deque

pobierz = lambda : tuple(map(int, input().split()))
def main():
    n, m = pobierz()
    drogi = [[(False, i) for i in range(n)] for _ in range(n)]

    for _ in range(m):
        u, v = pobierz()
        drogi[u-1][v-1] = (True, v-1)
        drogi[v-1][u-1] = (True, u-1)

    if drogi[0][n-1][0]:
        drogi = list(map(lambda vedges : list(map(lambda bu : (not(bu[0]), bu[1]), vedges)), drogi))
        for i in range(n):
            drogi[i][i] = (False, i)

    drogi = list(map(lambda vs : list(filter(lambda bu : bu[0], vs)), drogi))
    drogi = list(map(lambda vs : list(map(lambda bu : bu[1], vs)), drogi))
    # print(drogi)
    def bfs():
        kolejka = deque()
        kolejka.append((0,0))
        odwiedzone = [False for _ in range(n)]
        odwiedzone[0] = True
        while kolejka:
            (v, dlugosc) = kolejka.popleft()
            if v == n-1:
                return dlugosc
            dplus = dlugosc + 1
            for u in drogi[v]:
                if not(odwiedzone[u]):
                    odwiedzone[u] = True
                    kolejka.append((u, dplus))
        return -1

    print(bfs())

main()
