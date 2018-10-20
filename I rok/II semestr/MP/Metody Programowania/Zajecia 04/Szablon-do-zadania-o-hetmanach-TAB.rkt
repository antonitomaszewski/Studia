#lang racket

(define (concatMap f xs)
  (if (null? xs)
      null
      (append (list (f (car xs))) (concatMap f (cdr xs)))))

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
    (let ((test (car positions))
          (rest (cdr positions)))
      (define (go positions)
        (if (null? positions)
            #t
            (and (not (= (car test) (caar positions))) ;;wiersze
                 (not (= (abs (- (car test) (caar positions)))
                         (abs (- (cdr test) (cdar positions))))) ;;przekatne
                 ( go (cdr positions))))) ;;nastepne
      (go rest)))
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