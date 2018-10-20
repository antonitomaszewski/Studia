#lang racket

(require racklog)

(%which (x)
        (%= (list x 1) '(2 1)))
;; czytaj znajdź takie x-sy, że (lista x 1) jest identyczna z listą (list 0 1)
(%which (x)
        (%/= (list x 1) '(0 1)))
(%which (x)
        (%/= 1 0))
(use-occurs-check? #t)
(%which (x)
        (%= x x))