#lang racket

;;(accumulate combiner null-value term a next b)
(define (identity x) x)
(define (inc x) (+ x 1))

(define (accumulate-iter combiner null-value term a next b)
  (define (accumulate01 wartosc a)
    (if (> a b)
        wartosc
        (accumulate01 (combiner wartosc (term a)) (next a))))
  (accumulate01 null-value a))

(accumulate-iter + 0 identity 0 inc 10)
(accumulate-iter * 1 identity 1 inc 5)

(define (accumulate-rek combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate-rek combiner null-value term (next a) next b))))

(accumulate-rek + 0 identity 0 inc 10)
(accumulate-rek * 1 identity 1 inc 5)
(accumulate-rek / 1 1 1 inc 10)
