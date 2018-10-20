#lang racket

(define (identity x) x)
(define (inc x) (+ x 1))
(define (square x) (* x x))
(define (pi-next x) (+ x 2))
(define (pi-term x) (* (/ (- x 1) x) (/ (+ x 1) x)))
(exact->inexact (/ 9 10)) ;;!!!

(define (product-iter term next s e)
  (define (product01 prev s)
    (if (> s e)
        prev
        (product01 (* prev (term s)) (next s))))
  (product01 1 s))

;;(define (pi-iter end)
  
  