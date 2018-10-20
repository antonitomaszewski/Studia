#lang typed/racket

(define-type Leaf 'leaf)
(define-type (Node A B) (List 'node A (Listof B)))
(define-type (Tree A) (U Leaf (Node A (Tree A))))

;typedef (const int*) ConstInt;
;ConstInt a = 5;

(define-predicate leaf? Leaf)
(define-predicate node? (Node Any Any))
(define-predicate tree? (Tree Any))

(: leaf Leaf)
(define leaf 'leaf)

(: node-val (All (A B) (-> (Node A B) A)))
(define (node-val x) (cadr x))

(: node-nodes (All (A B) (-> (Node A B) B)))
(define (node-nodes x) (caddr x))

(: make-node (All (A B) (-> A B (Node A B))))
(define (make-node val t) (list 'node val t))

(: dfs (All (A) (-> (Tree A) Boolean (Listof A))))
(define (dfs t b)
  (if (leaf? t)
      '()
      (append (if b null (node-val t))
              (dfs (car (node-nodes t)) false)
              (dfs (make-node (node-val t) (cdr (node-nodes t))) true))))


(define (dfs t)
  (if (leaf? t)
      '()
      (cons (node-val t)
              (map dfs (node-nodes t)))))


(define (dfs t)
  (if (leaf? t)
      '()
      (cons (node-val t)
              (dfs-list (node-nodes t)))))
(define (dfs-list t)
  (concat-map dfs t))
