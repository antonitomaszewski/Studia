def main():
      n, s = map(int, input().split())
      ans = sorted(list(map(int, input().split())))
      mid = int((n - 1) / 2)
      mediana = ans[mid]


      if (mediana == s):
            print(0)
            return
      elif (mediana > s):
            checked = ans[0:mid+1]
            checked = list(map(lambda ai : ai - s, checked))
            checked = list(filter(lambda ai : ai > 0, checked))
            print(sum(checked))
            return
      else:
            checked = ans[mid:]
            checked = list(map(lambda ai : s - ai, checked))
            checked = list(filter(lambda ai : ai > 0, checked))
            print(sum(checked))
            return
main()
