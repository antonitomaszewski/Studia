#lang racket

(define (wstaw-jeden x T)
  (if (leaf? T) (list 'hnode x 1 'leaf 'leaf)
      (if (< (elem-priority x) (elem-priority (node-elem T)))
          (let ((nowe (wstaw-jeden x (node-left T))))
            (list 'hnode (node-elem T) (rank T) nowe (node-right T)))
          (let ((nowe (wstaw-jeden (node-elem T) (node-left T))))
            (list 'hnode x (+ 1 (rank (node-right T))) nowe (node-right T))))))
(define (leaf? x) (eq? x 'leaf))
(define (node-elem T) (second T))
(define (elem-priority x) (first x))
(define (node-left T) (fourth T))
(define (node-right T) (fifth T))
(define (rank T) (if (leaf? T)
                     0
                     (third T)))

(define drzewo1 (list 'hnode (list 10 1) 2
                      (list 'hnode (list 9 2) 1 'leaf 'leaf)
                      'leaf))
(define x1 (list 9 3))
(define iter1 (wstaw-jeden x1 drzewo1))
(define iter3 (wstaw-jeden (list 11 0) iter1))


(define (wstaw-jeden01 x T)
  (if (leaf? T) (list 'hnode x 1 'leaf 'leaf)
      ;;(define dist (- (rank (node-left T)) (rank (node-right T))))
      (let ((dist (- (rank (node-left T)) (rank (node-right T)))))
        (if (or (> dist 0) (> (- (rank T) (rank (node-right T))) 1) (and (not (leaf? (node-left T))) (leaf? (node-right T))))
          (if (< (elem-priority x) (elem-priority (node-elem T)))
                 (let ((nowe (wstaw-jeden01 x (node-right T))))
                   (list 'hnode (node-elem T) (+ (rank nowe) 1) (node-left T) nowe))
                 (let ((nowe (wstaw-jeden01 (node-elem T) (node-right T))))
                   (list 'hnode x (+ (rank nowe) 1) (node-left T) nowe)))
          (if (< (elem-priority x) (elem-priority (node-elem T)))
              (let ((nowe (wstaw-jeden01 x (node-left T))))
                (list 'hnode (node-elem T) (rank T) nowe (node-right T)))
              (let ((nowe (wstaw-jeden01 (node-elem T) (node-left T))))
                (list 'hnode x (+ 1 (rank (node-right T))) nowe (node-right T))))))))

(define (wstaw-jeden02 x T)
  (if (leaf? T) (list 'hnode x 1 'leaf 'leaf)
      ;;(define dist (- (rank (node-left T)) (rank (node-right T))))
      (let ((dist (- (rank (node-left T)) (rank (node-right T)))))
        (if (> dist 0)
          (if (< (elem-priority x) (elem-priority (node-elem T)))
                 (let ((nowe (wstaw-jeden02 x (node-right T))))
                   (list 'hnode (node-elem T) (+ (rank nowe) 1) (node-left T) nowe))
                 (let ((nowe (wstaw-jeden02 (node-elem T) (node-right T))))
                   (list 'hnode x (+ (rank nowe) 1) (node-left T) nowe)))
          (if (< (elem-priority x) (elem-priority (node-elem T)))
              (let ((nowe (wstaw-jeden02 x (node-left T))))
                (list 'hnode (node-elem T) (rank T) nowe (node-right T)))
              (let ((nowe (wstaw-jeden02 (node-elem T) (node-left T))))
                (list 'hnode x (+ 1 (rank (node-right T))) nowe (node-right T))))))))
(define (smieszne-laczenie02 T1 T2)
  (define (iter T1 T2)
    (cond [(leaf? T1) T2]
        [(leaf? T2) T1]
        ;;[(< (rank T1) (rank T2)) (smieszne-laczenie T2 T1)]
        [else (smieszne-laczenie02 (node-left T1) (smieszne-laczenie02 (node-right T1) (wstaw-jeden02 (node-elem T1) T2)))]))
  (if (> (rank T1) (rank T2))
      (iter T2 T1)
      (iter T1 T2)))

(define (iteracja funkcja wartosc ile)
  (if (= ile 0)
      wartosc
      (let ((w1 (funkcja wartosc wartosc)))
        (iteracja funkcja w1 (- ile 1)))))


(iteracja smieszne-laczenie02 drzewo1 2)


(define iter01 (wstaw-jeden01 x1 drzewo1))
(define iter03 (wstaw-jeden01 (list 11 0) iter01))
(define iter04 (wstaw-jeden01 (list 8 4) iter03))
(define iter05 (wstaw-jeden01 (list 11 1) iter04))
;;(define drzewo01 (list 'hnode (


(define (smieszne-laczenie T1 T2)
  (define (iter T1 T2)
    (cond [(leaf? T1) T2]
        [(leaf? T2) T1]
        ;;[(< (rank T1) (rank T2)) (smieszne-laczenie T2 T1)]
        [else (smieszne-laczenie (node-left T1) (smieszne-laczenie (node-right T1) (wstaw-jeden01 (node-elem T1) T2)))]))
  (if (> (rank T1) (rank T2))
      (iter T2 T1)
      (iter T1 T2)))

;;(smieszne-laczenie iter03 iter04)
;;(smieszne-laczenie drzewo1 drzewo1)
(define pierwsze (smieszne-laczenie iter05 iter05))
(define pierwsze01 (smieszne-laczenie pierwsze pierwsze))
(define pierwsze02 (smieszne-laczenie pierwsze01 drzewo1))


(iteracja smieszne-laczenie drzewo1 2)
(define przyklad (iteracja smieszne-laczenie drzewo1 2))

(define leaf 'leaf)
(define A (list 'hnode (list 0 0) 2
                (list 'hnode (list 1 1) 1 leaf leaf)
                (list 'hnode (list 2 2) 1 leaf leaf)))
(define k (iteracja smieszne-laczenie A 30))


             
      