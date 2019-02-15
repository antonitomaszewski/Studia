def main():
    s = input()
    n = len(s)
    m = int(input())

    Ai = [s[i] == s[i+1] for i in range(n-1)]
    Sumi = [0] * n
    Sumi[0] = Ai[0]
    for i in range(n-1):
        Sumi[i+1] = Sumi[i] + Ai[i]

    res = ''
    for i in range(m):
        li, ri = list(map(int, input().split()))
        res += str(Sumi[ri-1] - Sumi[li-1]) + '\n'
    print(res)

main()
