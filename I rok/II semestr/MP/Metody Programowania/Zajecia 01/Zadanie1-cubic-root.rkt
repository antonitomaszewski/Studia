#lang racket

(define (cube-root x z)
  (define (cube x)
    (* x x x))
  (define (better x y)
    (/ (+ (/ x (* y y)) (* 2 y)) 3))
  (define (distance x y)
    (- (
    