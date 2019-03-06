def opt_dist(xs, D):
    ones = sum(xs)
    ds = [sum(xs[i:i+D]) for i in range(len(xs) - D + 1)]
    maximum = max(ds)
    toAdd = D - maximum
    toRemove = ones - maximum
    return toAdd + toRemove

for i in range(5, -1, -1):
    print("i=" + str(i) + " => " + str(opt_dist([0,0,1,0,0,0,1,0,0,0], i)))

def opt_dist_1(xs, D):
    ones = sum(xs)
    maximum = sum(xs[0:D])
    obecny = maximum
    for i in range(1, len(xs)-D+1):
        obecny += xs[i+D-1] - xs[i-1]
        maximum = max(maximum, obecny)
    toAdd = D - maximum
    toRemove = ones - maximum
    return toAdd + toRemove

opt_dist_1([0,0,1,0,0,0,1,0,0,0], 2)

def zpliku(namein = "Desktop/Infa/Sztuczna/Pracownia_1/Zad_4/input_1.4.txt", nameout = "Desktop/Infa/Sztuczna/Pracownia_1/Zad_4/output_1.4.txt"):
    fin = open(namein, 'r')
    fout = open(nameout, 'w+')
    for line in fin:
        xs, i = line.split()
        i = int(i)
        xs = [int(x) for x in list(xs)]
        fout.write(str(opt_dist_1(xs, i)))
        fout.write('\n')
    fout.close()
    fin.close()

zpliku()
