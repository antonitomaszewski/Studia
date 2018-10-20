#lang typed/racket

(: add (-> Real Real Real))
(define (add a b)
  (+ a b))
(: add-i (-> Real Real Real))
(define (add-i a b)
  (if (number? a)
      (+ a b)
      '()))

(add 4 2)

(define (a) 5)
