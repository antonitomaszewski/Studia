#lang racket
(define (concatMap f xs)
  (if (null? xs)
      null
      (append (f (car xs)) (concatMap f (cdr xs)))))

(define (sublists X)
  (if (null? X)
      (list null)
      (concatMap (lambda (x)
                   (list x (cons (car X) x)))
                 (sublists (cdr X)))))
(remove-duplicates (sublists '()))
(remove-duplicates (sublists '(1)))
(remove-duplicates (sublists '(1 2)))
(remove-duplicates (sublists '(1 2 3)))
(remove-duplicates (sublists '(1 2 3 4)))
;;(remove-duplicates (sublists '(1 2 3 4 5)))
(sublists '())
(sublists '(1))
(sublists '(1 2))
(sublists '(1 2 3))
(sublists '(1 2 3 4))

(define (map-append f xs)
  (if (null? xs)
      xs
      (append (f (car xs)) (map-append f (cdr xs)))))