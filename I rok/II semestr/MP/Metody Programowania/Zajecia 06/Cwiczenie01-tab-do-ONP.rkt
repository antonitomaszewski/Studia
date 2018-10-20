#lang racket
(define (arith->rpn-tab e)
  (define (iter a r)
    (cond [(const? a) (cons a r)]
          [(binop? a)
           (iter (binop-left a)
                 (iter (binop-right a)
                       (cons (binop-op a) r)))])))