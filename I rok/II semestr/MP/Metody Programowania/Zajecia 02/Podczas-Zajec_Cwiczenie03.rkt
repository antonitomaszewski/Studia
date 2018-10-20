#lang racket


(define (square x) (* x x))
(define (inc x) (+ x 1))
(define (identity x) x)

(define (compose f1 f2)
  (lambda (x)
    (f1 (f2 x))))

(define (repeated p n)
  (lambda (x) (if (= 0 n)
                  x
                  ((repeated p (- n 1)) ((compose p identity) x)))))

((repeated square 1) 2)
((compose square square) 4)
((repeated inc 10) 0)
((repeated inc 0) 0)
  
      