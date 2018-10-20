#lang racket

(define (suma-kwadratow x y)
  (+ (* x x) (* y y)))

(define (sume-kwadratow-dwoch-wiekszych x y z)
  (if (> x y)
      (if (> y z)
          (+ (* x x) (* y y))
          (+ (* x x) (* z z)))
      (if (> x z)
          (+ (* x x) (* y y))
          (+ (* y y) ( * z z)))))

(sume-kwadratow-dwoch-wiekszych 2 -4 1)