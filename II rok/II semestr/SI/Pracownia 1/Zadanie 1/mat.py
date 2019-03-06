from collections import deque
from random import choice
from time import time


def bezwzgledneKrol(king):
    x = king[0]
    y = int(king[1])
    xs = [chr(xi) + str(yi) for xi in range(ord(x)-1, ord(x)+2) for yi in range(y-1, y+2)]
    xs = list(filter(lambda xy : 'a' <= xy[0] <= 'h' and '1' <= xy[1] <= '8', xs))
    xs = set(xs)
    xs.remove(king)
    return xs
bezwzgledneWieza("d4")
def bezwzgledneWieza(rook):
    # x, y = rook
    x = rook[0]
    y = int(rook[1])
    xs = [x + str(i) for i in range(1,9)]
    xs.extend([chr(c) + str(y) for c in range(ord('a'), ord('h')+1)])
    xs = set(xs)
    xs.remove(rook)
    return xs

def polaBiteKrol(king):
    return bezwzgledneKrol(king)
def polaBiteWieza(wking, wrook):
    wszystkie = bezwzgledneWieza(wrook)
    xrook, yrook = wrook
    xking, yking = wking
    if (xrook == xking):
        warunek = lambda xy : (lambda x, y : x != xking or (yrook <= y <= yking) or (y <= yrook <= yking) or (yrook >= y >= yking) or (y >= yrook >= yking))(*xy)
        wszystkie = set(filter(warunek, wszystkie))
    elif (yrook == yking):
        warunek = lambda xy : (lambda x, y : y != yking or (xrook <= x <= xking) or (x <= xrook <= xking) or (xrook >= x >= xking) or (x >= xrook >= xking))(*xy)
        wszystkie = set(filter(warunek, wszystkie))
    return set(wszystkie)

def polaDoWejsciaWKrol(wking, wrook, bking):
    wszystkie = bezwzgledneKrol(wking)
    zabronione = polaBiteKrol(bking)
    wszystkie.difference_update(zabronione)
    wszystkie.difference_update(set([wrook]))
    return wszystkie
def polaDoWejsciaBKrol(wking, wrook, bking):
    wszystkie = bezwzgledneKrol(bking)
    zabronionePrzezBialegoKrola = polaBiteKrol(wking)
    zabronionePrzezBialaWieze = polaBiteWieza(wking, wrook)
    wszystkie.difference_update(zabronionePrzezBialegoKrola)
    wszystkie.difference_update(zabronionePrzezBialaWieze)
    return wszystkie
def polaDoWejsciaWieza(wking, wrook):
    wszystkie = polaBiteWieza(wking, wrook)
    wszystkie.difference_update(set([wking]))
    return wszystkie

def czyMat(wking, wrook, bking):
    dozwolone = polaDoWejsciaBKrol(wking, wrook, bking)
    return not(dozwolone) and bking in polaBiteWieza(wking, wrook)

def ruchyWiezy(wking, wrook, bking):
    polaW = sorted(polaDoWejsciaWieza(wking, wrook))
    # wieży opłaca się ruszać wyłącznie na bandy
    polaW = list(filter(lambda xy : xy[0] == 'a' or xy[0] == 'h' or xy[1] == '1' or xy[1] == '8', polaW))
    return polaW
def ruchyBialegoKrola(wking, wrook, bking):
    polaK = polaDoWejsciaWKrol(wking, wrook, bking)
    polaK = sorted(polaK)
    return polaK
def ruchyCzarnegoKrola(wking, wrook, bking):
    polaBK = polaDoWejsciaBKrol(wking, wrook, bking)
    polaBK = set(filter(lambda xy : xy != wrook, polaBK))
    polaBK = sorted(polaBK)
    return polaBK


def ruchyBialego(pozycja):
    wking, wrook, bking = pozycja
    polaWK = ruchyBialegoKrola(*pozycja)
    polaWR = ruchyWiezy(*pozycja)
    polaWK = list(map(lambda xy :((xy, wrook, bking), "K"+xy), polaWK))
    polaWR = list(map(lambda xy : ((wking, xy, bking), "R"+xy), polaWR))
    return polaWK + polaWR
def ruchyCzarnego(pozycja):
    wking, wrook, bking = pozycja
    polaBK = ruchyCzarnegoKrola(*pozycja)
    polaBK = list(map(lambda xy : ((wking, wrook, xy), xy), polaBK))
    return polaBK


def pierwszyRuch(pozycja, color):
    if color == 'white':
        ruchyB = ruchyBialego(pozycja)
        odwiedzone = map(lambda ph : (lambda pos, hist : pos)(*ph), ruchyB)
        ruchyB = list(map(lambda ph : (lambda pos, hist : (pos, 2, "1. " + hist)) (*ph), ruchyB))
        return deque(ruchyB), set(odwiedzone)
    else:
        odwiedzone = [pozycja]
        start = [(pozycja, 2, "1. ...")]
        return deque(start), set(odwiedzone)


def bfs(pozycja, color):
    def ruchy(pozycja, mv = 1, historia = ' '):
        def f(pos, hist):
            ruchyW = ruchyBialego(pos)
            wszystkieRuchy = list(map(lambda ph : (lambda p, h: (p, mv+1, historia + ' ' + hist + '\n' + str(mv) + '. ' + h)) (*ph), ruchyW))
            wszystkieRuchy = list(filter(lambda pmh : pmh[0] not in visited, wszystkieRuchy))
            visited.update(list(map(lambda pmh : pmh[0], wszystkieRuchy)))
            return wszystkieRuchy
        ruchyB = ruchyCzarnego(pozycja)
        res = deque()
        for rb in ruchyB:
            res.extendleft(f(*rb))
        return res

    kolejka, visited = pierwszyRuch(pozycja, color)
    while kolejka:
        (position, move, hist) = kolejka.popleft()
        if czyMat(*position):
            return hist + "#"
        ruchyOba = ruchy(position, move, hist)
        kolejka.extend(ruchyOba)



def main(pobranie=input):
    color, wking, wrook, bking = pobranie().split()
    timeStart = time()
    startowe = "Pozycja startowa : " + "K"+wking + " " + "R"+wrook + " " + bking + ' \n'
    # zamiana = lambda x, y : (x,int(y))
    # wking = zamiana(*wking)
    # wrook = zamiana(*wrook)
    # bking = zamiana(*bking)
    wynik = bfs((wking, wrook, bking), color)
    timeStop = time()
    print('czas =', end=' ')
    print(timeStop - timeStart, end=' ')
    print('sekund')
    return startowe + wynik

# black a1 d5 h8
print(main())

# black c1 h8 a1
print(main())

# black a1 a2 a3
print(main())

# black c1 h1 a2
print(main())

# white c1 a1 h8
print(main())
# white c1 f8 a1
print(main())




# f = open('Desktop/Infa/Sztuczna/Pracownia_1/zad1_input.txt', "w+")
# a = f.read()
# f.write('black c1 h8 a1 \n\
# black a1 a2 a3 \n\
# black c1 h1 a2 \n\
# white c1 a1 h8 \n\
# white c1 f8 a1')
# a = f.read()
# a
# f.close()
# black c1 h8 a1
# white c1 h8 a1
# black a1 a2 a3
# black c1 h1 a2
# white c1 a1 h8
# white c1 f8 a1

# ZE SPRAWDZACZKI
# white h6 a4 d4
# black b4 f3 e8
# white a1 e3 b7
# black h7 a2 f2
# black a2 e4 a4
# black g8 h1 c4

def zpliku(namein = "Desktop/Infa/Sztuczna/Pracownia_1/Zad_1/input_1.1.txt", nameout = "Desktop/Infa/Sztuczna/Pracownia_1/Zad_1/output_1.1.txt"):
    fin = open(namein, 'r')
    fout = open(nameout, 'w')
    for line in fin:
        fout.write(main(lambda : line))
        fout.write('\n\n')
    fout.close()
    fin.close()

zpliku()



















.
