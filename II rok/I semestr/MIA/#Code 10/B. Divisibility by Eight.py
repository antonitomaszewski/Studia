def main():
    n = input()
    lenn = len(n)
    digits = [n[i] for i in range(lenn)]

    combinations = [int(n[i]) for i in range(lenn)]
    checked = list(filter(lambda ni : not(ni % 8), combinations))
    if len(checked):
        print('Yes')
        print(checked[0])
        return

    combinations = [int(n[i] + n[j]) for i in range(lenn) for j in range(i+1,lenn)]
    checked = list(filter(lambda ni : not(ni % 8), combinations))
    if len(checked):
        print('Yes')
        print(checked[0])
        return

    combinations  = [int(n[i] + n[j] + n[k]) for i in range(lenn) for j in range(i+1,lenn) for k in range(j+1,lenn)]
    checked = list(filter(lambda ni : not(ni % 8), combinations))

    if len(checked):
        print('Yes')
        print(checked[0])
        return
    else:
        print('No')

main()
