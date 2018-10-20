#lang racket

(require racklog)
(define %member
  (%rel (x y xs)
    [(x (cons x xs))]
    [(x (cons y xs))
      (%member x xs)]))

(define %member-2
  (%rel (x xs)
    [(x (cons x (_)))]
    [(x (cons (_) xs))
      (%member-2 x xs)]))


(define succ
  (lambda (x)
    (vector 'succ x)))

(define %add
  (%rel (x y z)
    [(0 y y)]
    [((succ x) y (succ z))
      (%add x y z)]))
 
(define %times
  (%rel (x y z z1)
    [(0 y 0)]
    [((succ x) y z)
     (%times x y z1)
     (%add y z1 z)]))

(define %factorial
  (%rel (x y y1)
    [(0 (succ 0))]
    [((succ x) y)
      (%factorial x y1)
      (%times (succ x) y1 y)]))
