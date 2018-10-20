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
       (natural? (caddr h))))

(define (make-node elem heap-a heap-b)
  ;;; XXX: fill in the implementation
  (cond ((and (leaf? heap-a) (leaf? heap-b)) (list 'hnode elem 1 leaf leaf))
        ;;((leaf? heap-a) (heap-insert elem heap-b))
        ;;((leaf? heap-b) (heap-insert elem heap-a))
        (else (if (< (rank heap-a) (rank heap-b))
                  (list 'hnode elem (inc (rank heap-a)) heap-b heap-a)
                  (list 'hnode elem (inc (rank heap-b)) heap-a heap-b)))))

(define (node-elem h)
  (second h))

(define (node-left h)
  (fourth h))

(define (node-right h)
  (fifth h))

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

(define empty-heap leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-insert elt heap)
  (heap-merge heap (make-node elt leaf leaf)))

(define (heap-min heap)
  (node-elem heap))

(define (heap-pop heap)
  (heap-merge (node-left heap) (node-right heap)))

(define (heap-merge T1 T2)
  (cond
   [(leaf? T1) T2]
   [(leaf? T2) T1]
   ;; XXX: fill in the implementation
   (else (if (< (elem-priority (node-elem T1))
                     (elem-priority (node-elem T2)))  ;;wybieramy min z T1 i T2, ktore wyladuje na szczycie
                  (let ((nowe (heap-merge (node-right T1) T2)))  ;;wybieramy krotsze z drzew z tego ktore ostrzyglismy, aby sie mniej napracowac 
                    (if (< (rank (node-left T1)) (rank nowe))  ;;krotsze idzie na prawo
                        (list 'hnode (node-elem T1) (inc (rank (node-left T1)))
                              nowe (node-left T1))
                        (list 'hnode (node-elem T1) (inc (rank nowe))
                              (node-left T1) nowe)))
                  (let ((nowe (heap-merge (node-right T2) T1)))
                    (if (< (rank (node-left T2)) (rank nowe))
                        (list 'hnode (node-elem T2) (inc (rank (node-left T2)))
                              nowe (node-left T2))
                        (list 'hnode (node-elem T2) (inc (rank nowe))
                              (node-left T2) nowe)))))))


(define A (list 'hnode (list 0 0) 2
                (list 'hnode (list 1 1) 1 leaf leaf)
                (list 'hnode (list 2 2) 1 leaf leaf)))
(define A1 (heap-merge A A))
(hnode? A1)
(define (iteracja funkcja wartosc ile)
  (if (= ile 0)
      wartosc
      (let ((w1 (funkcja wartosc wartosc)))
        (iteracja funkcja w1 (- ile 1)))))
(define A2 (iteracja heap-merge A 2))
(define k (iteracja heap-merge A 1000))
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

(define proba1 (randlist 10 10))
(define wynik1 (heapsort proba1))
proba1
(sorted? proba1)
wynik1
(sorted? wynik1)
(newline)

(define proba2 (randlist 10 50))
(define wynik2 (heapsort proba2))
proba2
(sorted? proba2)
wynik2
(sorted? wynik2)
(newline)

(define proba3 (randlist 5 10))
(define wynik3 (heapsort proba3))
proba3
(sorted? proba3)
wynik3
(sorted? wynik3)
(newline)

;;wspolpraca Andrzej Herman