#lang racket

(define (moj-list-ref Xs n)
  (if (= n 0)
      (car Xs)
      (moj-list-ref (cdr Xs) (- n 1))))
(moj-list-ref '(0 1 2 3 4 5 6 7) 7)