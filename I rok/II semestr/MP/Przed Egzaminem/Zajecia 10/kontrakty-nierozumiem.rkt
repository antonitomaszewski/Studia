#lang racket
(define (inc x) (+ x 1))

(define/contract (append xs ys)
  (let ([a (new-∀/c 'b)])
    (-> (listof a) (listof a) (listof a)))
  (if (null? xs)
      (map inc ys)
      (cons (car xs) (append (cdr xs) ys))))

(append '(1) '(0))