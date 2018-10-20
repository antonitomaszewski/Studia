#lang racket

(define (reverse L)
  (if (null? L)
      L
      (list (reverse (cdr L)) (car L))))

(define a (reverse (list 1 2 3 4 5)))
a

(define (reverse-iter L)
  (define (reverse-iter01 L P)
    (if (null? L)
        P
        (reverse-iter01 (cdr L) (list (car L) P))))
  (reverse-iter01 L null))