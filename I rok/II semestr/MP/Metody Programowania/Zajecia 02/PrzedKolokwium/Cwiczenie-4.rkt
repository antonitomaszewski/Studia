#lang racket
(define (square x) (* x x))
(define product
  (lambda (term next s e end previous)
    (if (> s e)
        (end (previous s)) 
        (* (term s) (product term next (next s) e end previous)))))
(product (lambda (x) (square (/ x (- x 1))))
         (lambda (x) (+ x 2))
         4.0
         1000.0
         (lambda (x) (/ 8 x))
         (lambda (x) (- x 1)))
(define (product-iter term next s e end previous)
  (define (iter s i)
    (if (> s e)
        (* i (end (previous s)))
        (iter (next s) (* i (term s)))))
  (iter s 1))
(product-iter (lambda (x) (square (/ x (- x 1))))
              (lambda (x) (+ x 2))
              4.0
              1000.0
              (lambda (x) (/ 8 x))
              (lambda (x) (- x 1)))
