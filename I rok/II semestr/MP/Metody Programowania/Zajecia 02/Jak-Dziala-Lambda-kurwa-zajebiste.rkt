#lang racket

(define sum
 (lambda (term next s e)
    (if (> s e)
        0
        (+ (term s) (sum term next (next s) e)))))
(define (zero x) 0)
(define (next x) (+ 1 x))
(sum zero next 10 20)


(define funkcja
  (lambda (x y z) (* x y z) (+ x y z) (* y z)))

(funkcja 0 1 2)
 
