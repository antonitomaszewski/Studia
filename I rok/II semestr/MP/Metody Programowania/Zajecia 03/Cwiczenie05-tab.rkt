#lang racket

(define (insert L n)
  (if (null? L)
      (cons n L)
      (if (<= (car L) n)
          (cons (car L) (insert (cdr L) n))
          (cons n L))))

(insert (list 1 6 7 8 9) 3)

(define (insert-sort-rek L)
  (if (null? L)
      L
      (insert (insert-sort-rek (cdr L)) (car L))))

(insert-sort-rek (list 1 10 2 3 4 10 99 0))

(define (insert-sort-iter L)
  (define (sort-iter L1 sorted)
    (if (null? L1)
        sorted
        (sort-iter (cdr L1) (insert sorted (car L1)))))
  (sort-iter L null))

(insert-sort-iter  (list 1 10 2 3 4 10 99 0))