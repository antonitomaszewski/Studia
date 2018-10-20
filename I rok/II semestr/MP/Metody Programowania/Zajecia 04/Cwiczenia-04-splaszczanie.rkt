#lang racket

(define (flatten t)
  (if (eq? t leaf)
      null
      (append (flatten (node-left t))
              (node-elem t)
              (flatten (node-right t)))))

(define (flatten-01 t xs)
  (if (eq? t leaf)
      xs
      (flatten-01 (node-left t)
            (cons (node-elem t) (flatten-01 (node-right t) xs)))))
