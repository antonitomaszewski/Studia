#lang racket

(define (p) (p))
(define (test x y)
  (if (= x 0)
      0 y))
(test 0 p)
dopóki nie musi użyć procedury p, to po prostu jej nie oblicza --->
interpreter jest gorliwy

