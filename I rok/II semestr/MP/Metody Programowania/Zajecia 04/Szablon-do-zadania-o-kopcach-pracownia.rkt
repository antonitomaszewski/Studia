#lang racket

(define (inc n)
  (+ n 1))

;;; ordered elements
(define (make-elem pri val)
  (cons pri val))

(define (elem-priority x)
  (car x))

(define (elem-val x)
  (cdr x))

;;; leftist heaps (after Okasaki)

;; data representation
(define leaf 'leaf)

(define (leaf? h) (eq? 'leaf h))

(define (hnode? h)
  (and (list? h)
       (= 5 (length h))
       (eq? (car h) 'hnode)
       (natural? (caddr h)))) ;;czy 3 el. listy jest liczba naturalna?

(define (make-node elem heap-a heap-b)
  (cond [(and (leaf? heap-a) (leaf? heap-b))
         (list 'hnode elem 1 'leaf 'leaf)]
        [(leaf? heap-a) (heap-insert elem heap-b)]
        [(leaf? heap-b) (heap-insert elem heap-a)]
        [else (let [(rank-a (node-rlength heap-a))
                    (rank-b (node-rlength heap-b))]
                (if (> rank-a rank-b)
                      (heap-merge (heap-insert elem heap-a) heap-b)
                      (heap-merge (heap-insert elem heap-b) heap-a)))]))

(define (poprawa h)
  (if (leaf? (node-left h))
      h
      h)
  (if (and (>= (elem-priority (node-elem h)) (elem-priority (node-elem (node-left h))))
           (>= (elem-priority (node-elem h)) (elem-priority (node-elem (node-right h)))))
      h
      (if (> (elem-priority (node-elem (node-left h))) (elem-priority (node-elem (node-right h))))
          (list 'hnode (node-elem (node-left h)) (+ (rank (node-right h)) 1)
                (poprawa (list 'hnode (node-elem h) (rank (node-left h)) (node-left (node-left h)) (node-right (node-left h))))
                (node-right h))
          (list 'hnode (node-elem (node-right h)) (+ (rank (node-right h)) 1) (node-left h)
                (poprawa (list 'hnode (node-elem h) (rank (node-right h)) (node-left (node-right h)) (node-right (node-right h))))))))
      
                    
        
  ;;; XXX: fill in the implementation
  ;;...)

(define (node-heap? h)
  (first h)) ;;'hnode
(define (node-elem h)
  (second h)) ;;priorytet(waga) + wartosc
(define (node-rlength h)
  (third h)) ;;ranga - dlugosc prawego poddrzewa

(define (node-left h)
  (fourth h)) ;;lewe poddrzewo

(define (node-right h)
  (fifth h)) ;; prawe poddrzewo

(define (hord? p h)
  (or (leaf? h)
      (<= p (elem-priority (node-elem h)))))

(define (heap? h)
  (or (leaf? h)
      (and (hnode? h)
           (heap? (node-left h))
           (heap? (node-right h))
           (<= (rank (node-right h))
               (rank (node-left h)))
           (= (rank h) (inc (rank (node-right h))))
           (hord? (elem-priority (node-elem h))
                  (node-left h))
           (hord? (elem-priority (node-elem h))
                  (node-right h)))))

(define (rank h)
  (if (leaf? h)
      0
      (third h)))

;; operations
(heap? (list 'hnode
  (list 11 0)
  2
  (list 'hnode
   (list 10 1)
   1
   (list 'hnode (list 9 3) 1 (list 'hnode (list 9 2) 1 (list 'hnode (list 8 4) 1 leaf leaf) leaf) leaf)
   leaf)
  (list 'hnode (list 8 3) 1 leaf leaf))) 
(define empty-heap leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-insert elt heap)
  (heap-merge heap (make-node elt leaf leaf)))

(define (heap-min heap)
  (node-elem heap))

(define (heap-pop heap)
  (heap-merge (node-left heap) (node-right heap)))

(define (heap-merge h1 h2)
  (cond
   [(leaf? h1) h2]
   [(leaf? h2) h1]
   [(< (rank h1) (rank h2)) (heap-merge h2 h1)]
   ;; XXX: fill in the implementation
   [else (if (> (elem-priority (node-elem h1)) (elem-priority (node-elem h2)))
             (list 'hnode (node-elem h1) (+ (rank h2) 1) (heap-merge (node-left h1) (node-right h1)) h2)
             (list 'hnode (node-elem h2) (+ (rank h2) 1) h1 (heap-merge (node-left h2) (node-right h2))))]))

(define lewe (list 'hnode '(10 1) 1 (list 'hnode '(9 2) 0 'leaf 'leaf) (list 'hnode '(8 3) 0 'leaf 'leaf)))
(define prawe (list 'hnode '(10 2) 1 (list 'hnode '(9 3) 0 'leaf 'leaf) (list 'hnode '(8 4) 0 'leaf 'leaf)))
(define wynik (heap-merge lewe prawe))
             


;;; heapsort. sorts a list of numbers.
(define (heapsort xs)
  (define (popAll h)
    (if (heap-empty? h)
        null
        (cons (elem-val (heap-min h)) (popAll (heap-pop h)))))
  (let ((h (foldl (lambda (x h)
                    (heap-insert (make-elem x x) h))
            empty-heap xs)))
    (popAll h)))

;;; check that a list is sorted (useful for longish lists)
(define (sorted? xs)
  (cond [(null? xs)              true]
        [(null? (cdr xs))        true]
        [(<= (car xs) (cadr xs)) (sorted? (cdr xs))]
        [else                    false]))

;;; generate a list of random numbers of a given length
(define (randlist len max)
  (define (aux len lst)
    (if (= len 0)
        lst
        (aux (- len 1) (cons (random max) lst))))
  (aux len null))