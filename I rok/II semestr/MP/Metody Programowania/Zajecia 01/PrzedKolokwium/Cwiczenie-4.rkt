#lang racket

(define (suma-kwadratow-dwoch-wiekszych a b c)
  (if (< a b)
      (if (< a c)
          (+ (* b b) (* c c))
          (+ (* b b) (* a a)))
      (if (< b c)
          (+ (* a a) (* c c))
          (+ (* a a) (* b b)))))
(suma-kwadratow-dwoch-wiekszych -1 2 3)