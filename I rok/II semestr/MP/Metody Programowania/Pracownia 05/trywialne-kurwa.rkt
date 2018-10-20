#lang racket

(define (clause-trival? c)
  (define (sprawdz prawda falsz)
    (if (or (null? prawda) (null? falsz))
        #f
     (if (member (car prawda) falsz)
        #t
        (sprawdz (cdr prawda) falsz))))
  (if (< (length (second c)) (length (third c)))
      (sprawdz (second c) (third c))
      (sprawdz (third c) (second c))))
(clause-trival? '(res-int (a c z) (e f x y z) 7 ((res-int (a b c) (d e f) 8 axiom) res-int (a c d) (b e f x y z) 8 axiom)))
(clause-trival? '(res-int (a c) (e f x y z) 7 ((res-int (a b c) (d e f) 8 axiom) res-int (a c d) (b e f x y z) 8 axiom)))
