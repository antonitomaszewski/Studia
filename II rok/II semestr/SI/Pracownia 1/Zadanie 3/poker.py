from functools import reduce
import random
flip = lambda f : lambda x, y : f(y, x)
foldr = lambda f, z, xs : reduce(flip(f), reversed(xs), z)
foldl = lambda f, z, xs : reduce(f, xs, z)
removeDuplicates = lambda xs : list(set([tuple(x) for x in xs]))
# kier - heart
# karo - diamond
# trefl - club
# pik - spade
# as = Ace
# król - King
# królowa - Queen
# walet - Jack
# figury zapisuję od 1..9 aby zgadzało się że każdy jest jednoznakowy, a i
blotki = [str(i) for i in range(1,10)]
figury = ['J', 'Q', 'K', 'A']
kolory = ['h', 'd', 'c', 's']
order = {'1' : 1, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '8' : 8, '9' : 9, 'J' : 11, 'Q' : 12, 'K' : 13, 'A' : 14}
orderReka = {'wysokakarta' : 0, 'para' : 1, 'dwiepary' : 2, 'trojka' : 3, 'street' : 4, 'kolor' : 5, 'full' : 6, 'kareta' : 7, 'poker' : 8}


# porownajUklady(uklady(["4h", '3s', '9d', '5c', '1h']), uklady(["4h", 'Qs', '9d', '1c', '5h']))
def porownajUklady(u_1, u_2):
    val_1, nam_1, u1 = u_1
    val_2, nam_2, u2 = u_2
    if orderReka[nam_1] > orderReka[nam_2]:
        return (u_1, 'Pierwszy')
    elif orderReka[nam_1] < orderReka[nam_2]:
        return (u_2, "Drugi")
    else:
        m1 = max(u1, key=lambda x : order[x[0]])
        m2 = max(u2, key=lambda x : order[x[0]])
        if m1 > m2:
            return (u_1, 'Pierwszy')
        elif m1 < m2:
            return (u_2, "Drugi")
        else:
            return (u1, "Rowne")
def uklady(uklad):
    paraWartosc = lambda vc_1, vc_2 : (lambda v_1, c_1, v_2, c_2 : v_1 == v_2)(*vc_1, *vc_2)
    paraKolor = lambda vc_1, vc_2 : (lambda v_1, c_1, v_2, c_2 : c_1 == c_2)(*vc_1, *vc_2)
    paraNastepnik = lambda vc_1, vc_2, ile : (lambda v_1, c_1, v_2, c_2 : order[v_1]+ile == order[v_2])(*vc_1, *vc_2)

    uklad = sorted(uklad, key = lambda x : order[x[0]])

    parowanie = [list(filter(lambda karta_2 : paraWartosc(karta_1, karta_2), uklad)) for karta_1 in uklad]

    kolorowanie = [list(filter(lambda karta_2 : paraKolor(karta_1, karta_2), uklad)) for karta_1 in uklad]
    kolor = list(filter(lambda grupa : len(grupa) == 5, kolorowanie))

    nastepnictwo = [(uklad[0], karta_2, j) for j, karta_2 in enumerate(uklad)]
    nastepnictwo = list(filter(lambda k_1k_2ile : paraNastepnik(*k_1k_2ile), nastepnictwo))
    nastepnictwo = [k1k2ile[1] for k1k2ile in nastepnictwo]
    street = list(filter(lambda grupa : len(grupa) == 5, [nastepnictwo]))

    kareta = list(filter(lambda grupa : len(grupa) >= 4, parowanie))

    trojka = list(filter(lambda grupa : len(grupa) == 3, parowanie))
    dwojka = list(filter(lambda grupa : len(grupa) == 2, parowanie))
    dwojka = removeDuplicates(dwojka)
    dwiePary = len(dwojka) == 2

    if kolor and street:
        poker = street[0]
        return (poker, 'poker', uklad)
    elif kareta:
        return (kareta[0][:4], 'kareta', uklad)
    elif trojka and dwojka:
        full = list(trojka[0]) + list(dwojka[0])
        return (full, 'full', uklad)
    elif kolor:
        return (kolor[0], 'kolor', uklad)
    elif street:
        return (street[0], 'street', uklad)
    elif trojka:
        return (trojka[0], 'trojka', uklad)
    elif dwiePary:
        dwiePary = dwojka[0] + dwojka[1]
        return (dwiePary, "dwiepary", uklad)
    elif dwojka:
        return (dwojka[0], 'para', uklad)
    else:
        return (uklad[4], 'wysokakarta', uklad)


def podstawowy():
    # ~0.08 DLA BLOTKARZA, 0.92 DLA FIGURANTA
    file = 0
    bile = 0
    ile = 1000
    for i in range(ile):
        figuranckie = [f+c for f in figury for c in kolory]
        blotkarskie = [b+c for b in blotki for c in kolory]
        random.shuffle(figuranckie)
        random.shuffle(blotkarskie)
        # random.sample(xs, n) 
        flos = figuranckie[:5]
        blos = blotkarskie[:5]


        fuklad = uklady(flos)
        buklad = uklady(blos)
        zwyciesca = porownajUklady(fuklad, buklad)
        if zwyciesca[1] == 'Pierwszy':
            file+=1
        elif zwyciesca[1] == 'Drugi':
            bile+=1
        else:
            file+=1
            bile+=1
    return(bile/ile, file/ile)
podstawowy()


def usuwany():
    ile = 1000
    for usuwamy in range(0, 9):
        file = 0
        bile = 0
        for _ in range(ile):
            blotkarskie = [b+c for b in blotki[usuwamy:] for c in kolory]
            figuranckie = [f+c for f in figury for c in kolory]
            if(usuwamy == 8):
                blotkarskie+=[random.choice([b+c for b in blotki[:usuwamy] for c in kolory])]
            random.shuffle(figuranckie)
            random.shuffle(blotkarskie)
            flos = figuranckie[:5]
            blos = blotkarskie[:5]


            fuklad = uklady(flos)
            buklad = uklady(blos)
            zwyciesca = porownajUklady(fuklad, buklad)
            if zwyciesca[1] == 'Pierwszy':
                file+=1
            elif zwyciesca[1] == 'Drugi':
                bile+=1
            else:
                file+=1
                bile+=1
        print(bile/ile)
    # return(bile/ile, file/ile)

usuwany()

def prawdopodobienstwa(xs):
    wyniki = [0 for _ in range(9)]
    ile = 1000
    for _ in range(1000):
        f = xs
        random.shuffle(f)
        flos = f[:5]
        fuklad, name, zadany = uklady(flos)
        wyniki[orderReka[name]] += 1
    D = dict()
    for k, v in orderReka.items():
        D[k]=wyniki[v]/ile
    return D

def prawdopodobienstwaFiguranta():
    figuranckie = [f+c for f in figury for c in kolory]
    return prawdopodobienstwa(figuranckie)

def prawdopodobienstwaBlotkarza():
    blotkarskie = [b+c for b in blotki for c in kolory]
    return prawdopodobienstwa(blotkarskie)


prawdopodobienstwa(["9h", '8h', '7h', '6h', '5h'])
prawdopodobienstwaFiguranta()
prawdopodobienstwaBlotkarza()
