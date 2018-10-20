#lang racket

(define (mirror t)
  (if (node? t)
      (make-node (node-val t) (mirror (node-right t)) (mirror (node-left t)))
      t))
(mirror '(node 0 (node 1 (leaf 3) (leaf 4))
                 (node 5 (leaf 6) (leaf 7))))
(mirror (mirror '(node 0 (node 1 (leaf 3) (leaf 4))
                 (node 5 (leaf 6) (leaf 7)))))

(define (tree-flatten t)
  (define (pomoc t acc)
    (if (leaf? t)
        acc
        (pomoc (node-left t) (cons (node-val t) (pomoc (node-right t) acc)))))
  (pomoc t '()))