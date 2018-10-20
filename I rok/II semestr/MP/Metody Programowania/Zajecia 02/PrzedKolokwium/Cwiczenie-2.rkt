#lang racket
(define (square x) (* x x))
(define (inc n) (+ n 1))
(define (compose f g)
  (f (g)))
(define (compose-lambda f g)
  (lambda (x) (f (g x))))
((compose-lambda square inc) 5)
((compose-lambda inc square) 5)