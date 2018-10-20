#lang racket

(define (compose f1 f2)
  (lambda (x) (f1 (f2 x))))
(define (identity x) x)
(define (repeated p n)
  (if (= n 0)
      identity
      (compose p (repeated p (- n 1)))))
((repeated (lambda (x) (+ x 1)) 10) 0)
((repeated (lambda (x) (+ x 1)) 0) 0)