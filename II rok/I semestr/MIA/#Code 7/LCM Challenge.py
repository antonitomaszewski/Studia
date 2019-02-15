def main():
    n = int(input())

    if (n <= 2):
        print(n)
        return
    elif (n % 2 == 1):
        print (n * (n - 1) * (n - 2))
        return
    elif (n % 3 != 0):
        print(n * (n - 1) * (n - 3))
        return
    else:
        print((n - 1) * (n - 2) * (n - 3))
        return

main()
