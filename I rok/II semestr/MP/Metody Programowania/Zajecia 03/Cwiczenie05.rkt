#lang racket

(define L (list 1 2 4 9 10))
L
(define (insert-iter L n)
  (define (insert01 L n k)
    (if (null? L)
        (list k n)
        (if (>= (car L) n)
            (list k n L)
            (if (null? k)
                (insert01 (cdr L) n (car L))
                (insert01 (cdr L) n (list k (car L)))))))
  (insert01 L n null))

(insert-iter L 11)

(define (insert-rek L n)
  (if (or (null? L) (>= (car L) n))
      (cons n L)
      (cons (car L) (insert-rek (cdr L) n))))

(insert-rek L 0)

(define (insert-sort L)
  (insert-rek (insert-sort (cdr L)) (car L)))
      