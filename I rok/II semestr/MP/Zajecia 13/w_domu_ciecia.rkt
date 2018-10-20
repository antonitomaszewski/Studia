#lang racket

(require racklog)

(define %factorial
  (%rel (x y x1 y1)
        [(0 1) !] ;; tu cięcie -- !, nie pozwala szukać rozwiązań przy przejsciu z 0 do a! dla a < 0
        ;;bez tego %more się nie skończy
        [(x y) (%< x 0) ! %fail] ;; tu główne cięcie
        [(x y) (%is x1 (- x 1))
               (%factorial x1 y1)
               (%is y (* y1 x))]))

(%which ()
        (%factorial 0 1))
(%which (n)
        (%factorial 7 n))
;; takie n, że n == 7!


(define %if-then-else
  (%rel (p q r)
        [(p q r) p ! q]
        [(p q r) r]))

(define %not
  (%rel (g)
        [(g) g ! %fail]
        [(g) %true]))