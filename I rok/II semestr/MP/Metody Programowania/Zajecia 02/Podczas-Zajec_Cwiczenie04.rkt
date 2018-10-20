#lang racket

(define (inc n) (+ n 1))
(define (square x) (* x x))
(define (identity x) x)

(define product
  (lambda (term next s e)
    (if (> s e)
        1
        (* (term s) (product term next (next s) e)))))

(define sum
  (lambda (term next s e)
    (if (> s e)
        0
        (+ (term s) (sum term next (next s) e)))))

(define (sum-pi-alt n e)
  (define (sum-pi-term s)
    (/ 1 (* s (+ s 2))))
  (define (sum-pi-next s)
    (+ s 4))
  (sum sum-pi-term (lambda (s) (+ s 4)) n e))

(product identity inc 1 6)

(define (term-gora n) (square (* 2 n)))
(define (term-dol n) (square (+ (* 2 n) 1)))
(define (pi koniec)
  (* 16.001 koniec (/
      (product term-gora inc  2 koniec)
      (product term-dol inc 1 koniec))))

(term-gora 3)
(term-dol 1)

(pi 500)

(define (term-ogolny n) (square (/ (* n 2) (- (* 2 n) 1))))
(define (pi2 koniec)
  (* 4.0001 (/ 1 koniec) (product term-ogolny inc 2 koniec)))

(pi2 1000)

