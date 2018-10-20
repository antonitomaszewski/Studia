#lang typed/racket

(: dist (All (A) (->i (A number?) (A number?) Real)))
(define (dist x y)
  (abs (- x y)))

(: average (All (A) (->i (A real?) (A real?) Real)))
(define (average x y)
  (/ (+ x y) 2))

(: square (All (A) (->i (A real?) Real)))
(define (square x)
  (* x x))

(: sqrt (->i (argumenty) (result))
(define (sqrt x)
  ;; lokalne definicje
  ;; poprawienie przybliżenia pierwiastka z x
  (: improve (-> Real Real))
  (define (improve approx)
    (average (/ x approx) approx))
  ;; nazwy predykatów zwyczajowo kończymy znakiem zapytania
  (: good-enough? (-> Real Boolean))
  (define (good-enough? approx)
    (< (dist x (square approx)) 0.0001))
  ;; główna procedura znajdująca rozwiązanie
  (: iter (-> Real Real))
  (define (iter approx)
    (cond
      [(good-enough? approx) approx]
      [else                  (iter (improve approx))]))
  
  (iter 1.0))

