#lang racket

(define (identity x) x)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0) identity
      (compose f (repeated f (- n 1)))))

;;(lambda (x) (p x)) === p
;;(compose f identity) === (lambda (x) (f (identity x))) === f
