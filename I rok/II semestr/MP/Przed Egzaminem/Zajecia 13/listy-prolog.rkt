#lang racket

(require racklog)

#|
% list_member(X,Y) = X należy do listy Y
% reimplementacja standardowego member(X,Y)
list_member(X, [X|_]).
list_member(X, [_|Y]) :-
        list_member(X, Y).
|#

(define %my-member
  (%rel (x y ys)
        [(x (cons x ys))]
        [(x (cons y ys))
         (%my-member x ys)]))
(%which (x) (%my-member 1 x))
(%which (x) (%my-member x '(1 2 3)))

#|
% list_append(X,Y,Z) = Z powstaje ze sklejenia X i Y
% reimplementacja standardowego append(X,Y,Z)
list_append([], X, X).
list_append([H|T], X, [H|Y]) :-
        list_append(T, X, Y).
|#

(define %my-append
  (%rel (x xs ys zs)
        [(null xs xs)]
        [((cons x xs) ys (cons x zs))
         (%my-append xs ys zs)]))
(%find-all (x y) (%my-append x y '(1 2 3)))
(%which (x y) (%my-append x '(1 2 3) y))
(%which (x y) (%my-append '(1 2 3) x y))


#|
% suma_elementow_listy(Lista, N) = N jest sumą elementów należących do Listy
suma_elementow_listy([], 0).
suma_elementow_listy([H|T], Wynik) :-
        suma_elementow_listy(T, Tmp),
        Wynik is H+Tmp.
|#

(define %my-sum-of-list
  (%rel (n m x xs)
        [(null 0)]
        [((cons x xs) n)
         (%my-sum-of-list xs m)
         (%is n (+ m x))]))
(%which (x) (%my-sum-of-list '(1 3 5) x))

#| NIEROZUMIEM
% jak wyżej, lecz z użyciem rekurencji prawostronnej
suma_elementow_listy_tail(Lista, Wynik) :-
        suma_elementow_listy_tail(Lista, 0, Wynik).
suma_elementow_listy_tail([], Wynik, Wynik).
suma_elementow_listy_tail([H|T], Akumulator, Wynik) :-
        Akumulator2 is H+Akumulator, suma_elementow_listy_tail(T, Akumulator2, Wynik).
|#

(define %my-sum-right
  (%rel (x xs n m result)
        [(xs 0 result)]
        [(null result result)]
        [((cons x xs) n result)
         (%is m (+ x n))
         (%my-sum-right xs m result)]))
