#lang racket

(define a (mcons 1 2))

(eq? a a) ;; #t
(eq? (mcons 1 2) (mcons 1 2)) ;; #f

(eq? (expt 2 100) (expt 2 100))
(eq? (expt 2 62) (expt 2 62))
(eq? (expt 2 61) (expt 2 61))
(expt 2 61)
(expt 2 62)
;;(eq? 4611686018427387904 4611686018427387904)
(equal? (expt 2 1000000) (expt 2 1000000)) ;;nie ma limitu
;;eq? true jesli maja referencje do tego samego obiektu


(define b (quote ()))
(null? b)
b
(define b1 (quote (1 2 .(3))))
(list? b1)
b1
;;(quote datum) == 'datum
(display '(you can 'me))