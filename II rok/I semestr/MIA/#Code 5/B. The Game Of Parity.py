def main():
    n, k = map(int, input().split())

    nieparzyste = sum(map(lambda x : int(x) % 2, input().split()))
    parzyste = n - nieparzyste

    ruchy = n-k

    if ruchy == 0:
        if nieparzyste % 2 == 1:
            print('Stannis')
        else:
            print('Daenerys')

    elif 2*nieparzyste <= ruchy:
        print('Daenerys')

    elif 2*parzyste <= ruchy:
        if (k % 2) == 0:
            print('Daenerys')
        else:
            print('Stannis')

    else:
        if (ruchy % 2) == 0:
            print('Daenerys')
        else:
            print('Stannis')
main()
