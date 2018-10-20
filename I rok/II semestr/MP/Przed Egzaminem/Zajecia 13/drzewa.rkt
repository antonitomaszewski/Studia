#lang racket

(require racklog)

(define %select
  (%rel (x xs y ys)
        [(x (cons x xs) xs)]
        [(y (cons x xs) (cons x ys))
         (%select y xs ys)]))

(%find-all (x) (%select 1 x '(2 3 4 5)))
(%find-all (x) (%select 1 '(2 3 4 5) x))
(%find-all (x xs) (%select x xs '(1 2)))

(define %my-member
  (%rel (x xs y)
        [(x (cons x xs))]
        [(y (cons x xs))
         (%my-member y xs)]))

(%find-all (x) (%my-member x '(1 2 3)))