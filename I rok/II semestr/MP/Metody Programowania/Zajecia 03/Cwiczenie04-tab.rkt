#lang racket

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys))))

(define (reverse-rek L)
  (if (null? L)
      L
      (append (reverse-rek (cdr L)) (list (car L)))))
(reverse-rek (list 1 2 3 4 5 6 7 8 9))

(define (reverse-iter L)
  (define (reverse-iter01 old new)
    (if (null? old)
        new
        (reverse-iter01 (cdr old) (cons (car old) new))))
  (reverse-iter01 L null))

(reverse-iter (list 1 2 3 4 5 6 7 8 9))

(define (rev-Append xs ys)
  (if (null? xs)
      ys
      (rev-Append (cdr xs) (cons (car xs) ys))))
(rev-Append (list `1 2 3 4 5) (list 6 7 8 9 0))

(define (insert xs n)
  (define (insert-iter front back)
    (cond [(null? back)
           (rev-Append front (list n))]
          [(< n (car back))
           (rev-Append front (cons n back))]
          [else (rev-Append (cons (car back) front)
                            (cdr back))]))
  (insert-iter null xs))

;;iteracyjne jest liniowe
;;rekurencyjne jestkwadratowe, bo append musi przejsc cala liste aby dokleic ja na koniec
;;Dowod ze iteracyjna jest rownowazna rekurencyjnej

(append null (list 1 2 3))
        