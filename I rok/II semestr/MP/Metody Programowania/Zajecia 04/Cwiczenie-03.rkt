#lang racket

(define (btree? t)
  (or (eq? t 'leaf)
      (and (list? t)
           (= 4 (length t))
           (eq? (car t) 'node)
           (btree? (caddr t))
           (btree? (cadddr t)))))

(define (mirror-tab t)
  (if (leaf? t)
      t
      (node (node-elem t) (mirror (node-right t)) (mirror (node-left t)))))
