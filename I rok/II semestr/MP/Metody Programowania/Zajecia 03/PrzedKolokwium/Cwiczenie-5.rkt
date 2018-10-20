#lang racket

(define (insert-rec xs n)
  (if (or (null? xs) (< n (car xs)))
      (cons n xs)
      (cons (car xs) (insert-rec (cdr xs) n))))

(define (insert-iter xs n)
  (define (iter xs n ys)
    (if (null? xs)
        (cons n ys)
        (if (< n (car xs))
            (append ys (list n) xs)
            (iter (cdr xs) n (append ys (list (car xs)))))))
  (iter xs n null))
            

(define (insert-sort-rec X)
  (if (null? X)
      null
      (insert-rec (insert-sort-rec (cdr X)) (car X))))

(define (insert-sort-iter X)
  (define (iter X sorted)
    (if (null? X)
        sorted
        (iter (cdr X)(insert-iter sorted (car X)))))
  (iter X null))

(insert-rec '(1 2 3 5 6) 0)