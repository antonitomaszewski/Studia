#lang racket

(define (moj-append . X)
  (define lacz (lambda (a b) (if (null? a) b (cons (car a) (lacz (cdr a) b)))))
  (foldr (lambda (x accu) (lacz x accu)) null X))