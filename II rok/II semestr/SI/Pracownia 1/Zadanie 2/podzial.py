from functools import reduce
flip = lambda f : lambda x, y : f(y, x)
foldr = lambda f, z, xs : reduce(flip(f), reversed(xs), z)
suffixy = lambda napis : foldr(lambda c, acc : [c+acc[0]]+acc, [napis[-1]], napis[:-1])

def dobreSuffixy(napis, S):
    maxlen = len(max(S, key=len))
    xs = [list(filter(lambda word : word in S, suffixy(napis[max(0, i-maxlen):i+1]))) for i in range(len(napis))]
    return xs

def podzial(napis, S):

    dlugosc = len(napis)
    legalne = [[]] + dobreSuffixy(napis, S)
    values = [-1 for _ in range(dlugosc+1)]
    values[0] = 0
    D = {key: '' for key in range(dlugosc+1)}

    for i in range(1, dlugosc+1):
        compare = lambda word : (lambda lenword : values[i-lenword] + lenword**2)(len(word))
        wszystkie = legalne[i]
        mozliwyPodzial = list(filter(lambda word : values[i-len(word)] > -1, wszystkie))
        if mozliwyPodzial:
            maximum = max(mozliwyPodzial, key=compare)
            values[i] = compare(maximum)
            D[i] = D[i-len(maximum)] + ' ' + maximum
    D[dlugosc] = D[dlugosc].replace(' ', '', 1)
    return D[dlugosc]


# podzial("abbaa", set([""]))

def zpliku(namein = "panTadeusz_in.txt", nameout = "panTadeusz_out.txt", slowa = "words_for_ai1.txt"):
    sciezka = "Desktop/Infa/Sztuczna/Pracownia_1/Zad_2/"
    namein = sciezka + namein
    nameout = sciezka + nameout
    fwords = open(sciezka+slowa, encoding="utf-8")
    Words = set()
    for line in fwords:
        Words.update(line.split())
    fwords.close()

    fin = open(namein, 'r', encoding="utf-8")
    fout = open(nameout, 'w', encoding="utf-8")
    for line in fin:
        p = podzial(line[:-1], Words)
        fout.write(p+'\n')

    fout.close()
    fin.close()

zpliku("ksiega1_in.txt", "ksiega1_out.txt")












































































































" as d".replace(' ','', 1)

### TESTY

napis = "abbaa"
slowa = set(["ab", "a", "bba"])
podzial(napis, slowa)

Slowa = set(["tama", "tematy", "kapustki", "nie", "z", "nosi", "ta", "matematyka", "pustki", "nie", "znosi"])
podzial("tamatematykapustkinieznosi", Slowa)

podzial('abc', set(['ab', 'bc']))
