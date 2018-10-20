#lang typed/racket

(: suffixes (All (A) (-> (Listof A) (Listof (Listof A)))))
(define (suffixes Xs)
  (if (null? Xs)
      null
      (cons (cdr Xs) (suffixes (cdr Xs)))))

(define/contract (suffixes-tab l)
  (let ([A (new-∀/c A)])
    (-> (Listof A) (Listof (Listof A))))
  (if (null? l)
      null
      (cons (cdr l) (suffixes-tab (cdr l)))))

