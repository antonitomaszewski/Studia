#lang racket
(define (make-rat n d) (list n d))
(define (rat-num r) (first r))
(define (rat-den r) (second r))
(define (rat? r) (and (list? r)
                      (= (length r) 2)
                      (integer? (rat-num r))
                      (natural? (rat-den r))
                      (not (= (rat-den r) 0))))
  