#lang racket

(require racket/contract)

(define/contract foo number? 42)

(define/contract (dist x y)
  (->i ([x number?] [y number?]) (result (x y) positive?))
  ;;(-> number? number? number?)
  (abs (- x y)))

(define/contract (average x y)
  (->i ([x number?] [y number?]) (result (x y) (lambda (z) (and/c (<= z x) (>= z y))))) 
  ;;(-> number? number? number?)
  (/ (+ x y) 2))

(define/contract (square x)
  (-> number? number?)
  (* x x))

(define/contract (sqrt x)
  (->i ([x positive?]) (result (x) (and/c positive? (lambda (y) (< (dist (square y) x) 0.0001)))))
  ;;(-> positive? positive?)
  ;; lokalne definicje
  ;; poprawienie przybliżenia pierwiastka z x
  (define (improve approx)
    (average (/ x approx) approx))
  ;; nazwy predykatów zwyczajowo kończymy znakiem zapytania
  (define (good-enough? approx)
    (< (dist x (square approx)) 0.0001))
  ;; główna procedura znajdująca rozwiązanie
  (define (iter approx)
    (cond
      [(good-enough? approx) approx]
      [else                  (iter (improve approx))]))
  
  (iter 1.0))