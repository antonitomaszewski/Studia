#lang racket

(define a (lambda (x) (cons 1 2)))
(a 0)
(lambda (x) 1)
((lambda (x) (car x)) (cons 1 2))
(car (lambda (x) x))
