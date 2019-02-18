pobierz = lambda : tuple(map(int, input().split()))
def main():
    n, m, x = pobierz()
    weights = [[0 for _ in range(n)] for _ in range(n)]

    for i in range(m):
        ai, bi, ci = pobierz()
        ai -= 1
        bi -= 1
        weights[ai][bi] = ci

    visited = [False for _ in range(n)]
    temp = [[0 for _ in range(n)] for _ in range(n)]
    koniec = n-1
    flow = 0

    def dfs(a):
        if (a == koniec):
            return True
        if (visited[a]):
            return False

        visited[a] = True

        for i in range(n):
            if (temp[a][i] >= flow):
                if (dfs(i)):
                    temp[a][i] -= flow
                    temp[i][a] += flow
                    return True
        return False

    left = 0
    right = 1e6
    middle = 0
    for _ in range(100):
        middle = (left + right) / 2

        for ai in range(n):
            for bi in range(n):
                temp[ai][bi] = (weights[ai][bi] / middle)

        f = 1e9
        bear = 0
        while(f > 0):
            for ai in range(n):
                visited[ai] = False
            flow = f
            if (dfs(0)):
                bear += f
            else:
                f /= 2
        if (bear >= x):
            left = middle
        else:
            right = middle
    print(middle*x)


main()
