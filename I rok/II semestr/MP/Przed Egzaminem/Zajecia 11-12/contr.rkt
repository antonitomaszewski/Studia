#lang racket


(define/contract (func xs)
  (let [(a (new-∀/c 'a))
        (b 1)]
    (-> (listof a) (cons/c b (listof a))))
    ; (-> (listof a) (listof (or/c b a))))
  xs)