#lang racket

(define (concatMap f xs)
  (if (null? xs)
      null
      (append (f (car xs)) (concatMap f (cdr xs)))))
;;(concatMap sqr '(1 2 3 4 5))

(define (from-to s e)
  (if (= s e)
      (list s)
      (cons s (from-to (+ s 1) e))))

(define (queens board-size)
  ;; Return the representation of a board with 0 queens inserted
  (define (empty-board)
    null)
    
  ;; Return the representation of a board with a new queen at
  ;; (row, col) added to the partial representation `rest'
  (define (adjoin-position row col rest)
    (if (null? rest)
        (cons row col)
        (cons (cons row col) rest)))
  ;; Return true if the queen in k-th column does not attack any of
  ;; the others
  (define (safe? k positions)
    (define (safe?-01 dodana positions)
      (if (null? positions)
          #t
          (if (or (= (car dodana) (caar positions))
                  (= (abs (- (car dodana) (caar positions)))
                     (abs (- (cadr dodana) (cadar positions)))))
              #f
              (safe?-01 dodana (cdr positions)))))
    (safe?-01 (cons (caar positions) (cdar positions)) (cdr positions)))
  ;; Return a list of all possible solutions for k first columns
  (define (queen-cols k)
    (if (= k 0)
        (list (empty-board))
        (filter
         (lambda (positions) (safe? k positions))
         (concatMap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (from-to 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
(queens 1)

;;wartosci boolowskie
;; wdi (-1 -1 ... -1)
;; lista numerow wierszy hetmanow, po k-tym wierszu sie konczy k<=n
;; lista par wspolrzednych (wiersz kolumna)
;;