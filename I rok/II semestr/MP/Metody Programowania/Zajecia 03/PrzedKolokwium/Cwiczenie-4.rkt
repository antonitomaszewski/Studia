#lang racket

(define (reverse-rec l)
  (if (null? l) null
      (append (reverse-rec (cdr l)) (list (car l)))))
(reverse-rec (list 2 3 4 5))
(define (reverse-iter l)
  (define (iter old new)
    (if (null? old)
        new
        (iter (cdr old) (cons (car old) new))))
  (iter l null))
(reverse-iter '(1 2 3 4 5))