#lang racket

(define (cont-frac num den k)
  (define (helper num den k i)
    (if (= i k)
        0
        (/ (num i) (+ (den i)) (helper num den k (+ i 1)))))
  (helper num den k 1))

(define (cont-frac-iter num den k val)
  (if (= k 0)
      val
      (cont-frac-iter num den (- k 1) (/ (num k) (+ (den k) val))))
  (cont-frac-iter num den k 0))

(define (build n d b)
  (/ n (+ d b)))