transpozycja = lambda xss : list(map(list, zip(*xss)))
import itertools, functools
foldl = lambda f, z, xs : functools.reduce(f, xs, z)
flatten = lambda xs : foldl(lambda acc, x : acc+x, [], xs)

# [-2, -2, ... , -2 | ...], lub [-1, ... -1, | ...] - bierze taki prefix
takeMinuses = lambda pos, v=-1 : list(itertools.takewhile(lambda x : x <= v, pos))
takeBothMinuses = lambda pos, v=-1 : (takeMinuses(pos, v), takeMinuses(reversed(pos), v))
przeplataj = lambda xs, v : foldl(lambda acc, x : acc + x + [v], [], xs)[:-1]
rozwin = lambda xs, v : list(map(lambda x : list(itertools.repeat(v, x)), xs))

# warunek complete : sum(conds) + len(conds) - 1 == len(pos) - takeMinuses(pos) - takeMinuses(reversed(pos))
def complete(conditions, position, vp=2, vm=-2):
    # [-1, -1, ... , -1, a1, ... , an, -1 ... -1] -> [a1, ... , an]
    minusStart, minusEnd = takeBothMinuses(position, vm)
    cutPosition = position[len(minusStart):len(position)-len(minusEnd)]

    sumConditions = sum(conditions)
    gaps = len(conditions) - 1
    if (sumConditions + gaps) != len(cutPosition):
        return (False, position)
    res = przeplataj(rozwin(conditions, vp), vm)
    res = minusStart + res + minusEnd
    return (res!=position,res)
complete((2,1), [-2,0,0,0,0])

# warunek overleap : len(conditions) == 1 && conditions[0] > half(len(position \ początek minusowy \ koniec minusowy))
def overleap(conditions, position, vp=2, vm=-2):
    minusStart, minusEnd = takeBothMinuses(position, vm)
    cutPosition = position[len(minusStart):len(position)-len(minusEnd)]
    cond = conditions[0]
    fromBeginning = cond
    fromEnd = len(cutPosition)-cond
    if len(conditions)>1 or fromBeginning <= fromEnd:
        return (False, position)
    common = fromBeginning - fromEnd
    res = cutPosition[:fromEnd] + [vp]*common + cutPosition[fromBeginning:]
    res = minusStart+res+minusEnd
    return (res!=position, res)
overleap((3,), [0,0,0,0,-2])

# znajduje luki, które sa mniejsze od najmniejszej warości, jaka mogłaby być tam włożona, i wypełnia minusami
def fulfillment(conditions, position, vp=2, vm=-2):
    def fulfillment_(conditions, position):
        nrLuki = 1
        res = []
        for key, group in itertools.groupby(position, lambda x : x!=vm):
            group = list(group)
            if key:
                doWyboru = conditions[:nrLuki]
                mini = min(doWyboru)
                if mini > len(group):
                    res.extend([vm]*len(group))
                else:
                    res.extend(group)
                    nrLuki += key
            else:
                res.extend(group)
        return (res!=position, res)
    b1, res1 = fulfillment_(conditions, position)
    b2, res2 = fulfillment_(tuple(reversed(conditions)), list(reversed(res1)))
    res = list(reversed(res2))
    return (res!=position, res)
fulfillment((2,2,2), [2,0,-2, 0,-2, 0,-2,0,0])

# działa dla jednego warunku, który ma już conajmniej 1 pozycję zaznaczoną. wypełnia wartości, między początkiem a końcem, i wyelimowuje z rozwiązania punkty, które leżą poza dopuszczalnym zasięgiem
def forbidden(conditions, position, vp=2, vm=-2):
    if len(conditions) > 1 or all(map(lambda x : x != vp, position)):
        return (False, position)
    pierwszy = 0
    while position[pierwszy] != vp:
        pierwszy+=1
    ostatni = len(position)-1
    while position[ostatni] != vp:
        ostatni-=1

    wnetrze = [vp]*(ostatni - pierwszy + 1)
    ileZostalo = conditions[0] - len(wnetrze)
    poczatekRozlaczny = [min(p, vm) for p in position[:max(pierwszy-ileZostalo, 0)]]
    koniecRozlaczny = [min(p, vm) for p in position[ostatni+ileZostalo+1:]]
    poczatekWspolny = position[max(pierwszy-ileZostalo,0):pierwszy]
    koniecWspolny = position[ostatni+1:ostatni+ileZostalo+1]

    res = poczatekRozlaczny + poczatekWspolny + wnetrze + koniecWspolny + koniecRozlaczny
    return (res!=position, res)
forbidden((4,), [0,0,0,0,0,2,0,0,0,0,-2])


# gdy mamy sytuację [-2,...,-2, 2 ...] to należy pociągnąć dwójki o wielkość conds[0], analogicznie z prawej strony. Jest rekurencyjna z `do`
def boundaries(conditions, position, vp=2, vm=-2):
    minusStart, minusEnd = takeBothMinuses(position, vm)
    position[len(position)-len(minusEnd)-1] != vp
    # gdy len(conditions)==1, to jest mniejwięcej równoznaczne z complete . forbidden
    if len(conditions)<=1 or all(map(lambda x : x != vp, position)) or (position[len(minusStart)] != vp and position[len(position)-len(minusEnd)-1] != vp):
        return (False, position)

    if position[len(minusStart)] == vp:
        resLeft = minusStart + [max(p, vp) for p in position[len(minusStart):len(minusStart)+conditions[0]]]
        if position[len(position)-len(minusEnd)-1]==vp:
            resRight = [max(p, vp) for p in position[len(position)-len(minusEnd)-1-conditions[-1]:len(position)-len(minusEnd)-1]] + minusEnd

            if len(conditions) == 2:
                wnetrze = [min(p, vm) for p in position[len(resLeft) : len(position) - len(resRight)]]
                res = resLeft + wnetrze + resRight
                return (res!=position, res)

            b, wnetrze = do(conditions[1:-1], position[len(resLeft)+1:len(position)-len(resRight)-1])
            wnetrze
            res = resLeft + [min(position[len(resLeft)+1], vm)] + wnetrze + [min(position[len(position)-len(resRight)-1], vm)] + resRight
            return (res!=position, res)
        else:
            b, wnetrze = do(conditions[1:], position[len(resLeft)+1:])
            res = resLeft + [min(position[len(resLeft)], vm)] + wnetrze
            return (res!= position, res)
    else:
        resRight = [max(p, vp) for p in position[len(position)-len(minusEnd)-1-conditions[-1]:len(position)-len(minusEnd)-1]] + minusEnd
        b, wnetrze = do(conditions[:-1], position[:len(position)-len(resRight)-1])
        res = wnetrze + [min(position[len(position)-len(resRight)-1], vm)] + resRight
        return (res!=position, res)
boundaries((2,4), [2,0,0,0,0,0,0,2])

# póki jest poprawa, przechodzi po wszystkich wnioskowaniach
def do(conds, position):
    b=True
    j=10
    res = position
    b_, res = rekoverleap(conds, res)
    while b and res:
        j-=1
        b=False
        b_, res = complete(conds, res)
        b = b or b_
        b_, res = overleap(conds, res)
        b = b or b_
        b_, res = fulfillment(conds, res)
        b = b or b_
        b_, res = forbidden(conds, res)
        b = b or b_
        b_, res = boundaries(conds, res)
        b = b or b_
        # b_, res = rekoverleap(conds, res)
        # b = b or b_
        b_, res = addNegation(conds, res)
        b = b or b_
    b_, res = rekoverleap(conds, res)
    return (res and res!=position, res)
do((3,4,1), [0,2,2,0,2,2,2,2,0,0])
do((2,2,2), [2,0,0,-2,0,0,0,0,-2,0,0,2])


def main(rows, columns):
    Macierz = [[0 for _ in columns] for _ in rows]
    # print(Macierz)
    b = True
    i = 10
    while b:
        i-=1
        b = False
        for i,r in enumerate(rows):
            b_, res = do(r, Macierz[i])
            b = b or b_
            Macierz[i] = res
        Macierz = transpozycja(Macierz)
        for j, c in enumerate(columns):
            b_, res = do(c, Macierz[j])
            b = b or b_
            Macierz[j] = res
        Macierz = transpozycja(Macierz)
    return Macierz
main([(1,)],[(1,)])
main([(1,),(2,)],[(1,),(2,)])


def printZagadka(xss):
    for xs in xss:
        for x in xs:
            if x==2:
                print('#', end='')
            elif x==-2:
                print('_', end='')
            else:
                print('.', end='')
        print('\n')
    print('\n')
rows, columns = [(5,),(1,1,1),(3,),(2,2),(5,)], [(2,2),(1,3),(3,1),(1,3),(2,2)]
printZagadka(main(rows, columns))

def wczytaj():
    wczytaj = lambda : tuple(map(int, f.readline().split()))
    import os
    os.getcwd()
    os.chdir("C:/Users/atom/Desktop/Infa/Sztuczna/Pracownia_2")
    f = open("obrazeczki", "r+")
    r, c = wczytaj()
    rows = []
    columns = []
    for _ in range(r):
        ri = wczytaj()
        rows.append(ri)
    for _ in range(c):
        ci = wczytaj()
        columns.append(ci)
    f.close()
    printZagadka(main(rows, columns))
wczytaj()

# o ile rekoverleap będzie robione po boundaries, to nigdy nie będzie sytuacji [...,-2, 2,2, ], a zawsze [...-2, ], więc mogę pogrupować before i after i będę miał liczbę wypełnionych luk, czyli ile należy ucią z conditions z początku i analogicznie z końca
def rekoverleap(conditions, position, vp=2, vm=-2):
    if len(conditions) <= 1:
        return (False, position)
    # conditions = (4,9)
    # position = [0 for _ in range(15)]
    # vp=2
    # vm=-2

    cut_ = lambda pos : list(itertools.takewhile(lambda x : x <= vm or x >= vp, pos))
    cut = lambda pos : (cut_(pos), cut_(reversed(pos)))
    done = lambda conds_ : len(list(filter(lambda x : x, itertools.starmap(lambda b, g : b, itertools.groupby(conds_, lambda x : x >= vp)))))
    # prefix i sufix już obliczony
    ciecieLewe, cieciePrawe = cut(position)
    wnetrze = position[len(ciecieLewe):len(position)-len(cieciePrawe)]
    wnetrze
    condsWnetrze = conditions[done(ciecieLewe):len(conditions)-done(cieciePrawe)]
    condsWnetrze
    conds = list(map(lambda x : tuple(reversed(x)), enumerate(condsWnetrze)))
    conds
    if len(conds) <= 1:
        return (False, position)
    maximum = max(conds)
    maximum


    before = tuple(itertools.starmap(lambda x,y : x, itertools.takewhile(lambda x : x != maximum, conds)))
    after = tuple(itertools.starmap(lambda x,y : x, itertools.takewhile(lambda x : x != maximum, list(reversed(conds)))))

    conajmniejZLewej = sum(before) + len(before)
    conajmniejZPrawej = max(sum(after) + len(after)-1,0)
    conajmniejZPrawej

    przycieteWnetrze = wnetrze[conajmniejZLewej : len(wnetrze)-conajmniejZPrawej]
    przycieteWnetrze
    b, res = overleap((maximum[0],), przycieteWnetrze)
    res
    if not(b):
        # skoro dla największej z wartości nic się nie udało, to chyba dla żadnej innej nie ma co próbować
        return (False, position)
    # wyciągam pierwszy indeks z lewej, który został zmieniony
    res = ciecieLewe + wnetrze[:conajmniejZLewej] + res + wnetrze[len(wnetrze)-conajmniejZPrawej:] + cieciePrawe
    return (res!=position, res)
b, res = rekoverleap((4,9), [0 for _ in range(15)])
rekoverleap((4,9), res)


rekoverleap((1,1,1,1,2), [0, 0, 0, 0, 0, 0, 0, 0, 2, 0])

addNegation((1,),[2,0,0,0,00])

def addNegation(conditions, position, vp=2, vm=-2):
    sumka = sum(conditions)
    if len(list(filter(lambda x : x >= vp, position))) != sumka:
        return (False, position)
    def f(a):
        if a > 0:
            return a
        return min(a, vm)
    res = list(map(f, position))
    return (res != position, res)



.
