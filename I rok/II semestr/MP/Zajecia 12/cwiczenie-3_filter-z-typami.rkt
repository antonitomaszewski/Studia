#lang typed/racket

(: filter_moj (All (A) (-> (-> A Boolean) (Listof A) (Listof A))))
(define (filter_moj p? Xs)
  (if (null? Xs)
      null
      (if (p? (car Xs))
          (cons (car Xs) (filter_moj p? (cdr Xs)))
          (filter_moj p? (cdr Xs)))))
(filter_moj positive? '( 1 2 -1 -2 0 4 -10))

(: a (Listof Integer))
(define a '(1 2 3))

(: funk (-> (U Integer (Listof Integer)) Integer))
(define (funk a)
  (if (list? a)
      (car a)
      a))

(funk '(1 2 3 4 5))
(funk 1)