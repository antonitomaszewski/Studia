#lang racket

(define (cube-root x)
  (define (better y)
    (/ (+ (/ x (* y y)) (* 2 y)) 3))
  (define (abs v)
    (if (> v 0)
        v
        (* v -1)))
  (define (cube a)
    (* a a a))
  (define (good-enough? p)
    (if (< (abs (- x (cube p))) 0.001)
        #t
        #f))
  (define (good-enough-poprz? y y-1)
    (if (< (abs (- y y-1)) 0.001)
        #t
        #f))
  (define (iter y y-1)
    (if (and (good-enough? y) (good-enough-poprz? y y-1))
        y
        (iter (better y) y)))
  (iter 1.0 0))

(cube-root 8)