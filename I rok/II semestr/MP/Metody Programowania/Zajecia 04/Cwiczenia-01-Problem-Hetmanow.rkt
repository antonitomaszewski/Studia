#lang racket

(define (concatMap f xs)
  (if (null? xs)
      null
      (append (list (f (car xs))) (concatMap f (cdr xs)))))
(concatMap sqr '(1 2 3 4 5))

(define (queens board-size)
  ;; Return the representation of a board with 0 queens inserted
  (define (empty-board)
    (define (from-to-01 s e)
      (if (= s e)
          (list -1)
          (cons -1 (from-to-01 (+ s 1) e))))
    (from-to-01 -1 board-size))
  (empty-board))

(queens 8)