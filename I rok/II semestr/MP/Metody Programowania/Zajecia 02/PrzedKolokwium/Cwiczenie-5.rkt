#lang racket

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      (null-value a)
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))
(accumulate * (lambda (x) (/ 2 (- x 2)))
            (lambda (x) (sqr (/ x (- x 1))))
            2.0
            (lambda (x) (+ x 2))
            1000)

(define (accumulate-iter combiner null-value term a next b poprawka)
  (define (iter wynik s)
    (if (> s b)
        (combiner wynik (poprawka s))
        (iter (combiner wynik (term s)) (next s))))
  (iter null-value a))
(accumulate-iter *
                 2.0
                 (lambda (x) (sqr (/ x (- x 1))))
                 2.0
                 (lambda (x) (+ x 2))
                 1000
                 (lambda (x) (/ 1 (- x 2))))