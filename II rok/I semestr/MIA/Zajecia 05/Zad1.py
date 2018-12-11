[n, m] = map(int, input().split())
ass = list(map(int, input().split()))
ls = [0] * (m)
for i in range(m):
    li = int(input())
    ls[i] = li

suffV = set()
suffN = [0] * (n+1)
for i in range(n-1, -1, -1):
    ai = ass[i]
    if (ai in suffV):
        suffN[i] = suffN[i+1]
    else:
        suffV.add(ai)
        suffN[i] = suffN[i+1] + 1
        # suffN.insert(0, suffN[0]+1)

for i in ls:
    print(suffN[i-1])
