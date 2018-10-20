#lang racket

(define (node? t)
  (and (pair? t)
       (eq? (car t) 'node)))

(define (node-left t) (second t))
(define (node-right t) (third t))

(define (relabel t i)
  (if (not (node? t))
      (cons i (+ i 1))
      (let*
        ([l (relabel (node-left t)
                     i)]
         [r (relabel (node-right t)
                     (cdr l))])
        (cons (list 'node (car l) (car r))
              (cdr l)))))
