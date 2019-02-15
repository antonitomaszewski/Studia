def main():
    n = int(input())
    ans = list(map(int, input().split()))

    m = int(input())
    bms = list(map(int, input().split()))

    gears = [bj/ai for bj in bms for ai in ans]
    checked = list(filter(lambda gear : gear == int(gear), gears))
    maximum = max(checked)
    checked = list(filter(lambda gear : gear == maximum, checked))
    print(len(checked))
main()
