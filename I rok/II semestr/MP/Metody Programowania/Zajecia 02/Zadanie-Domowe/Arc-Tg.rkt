#lang racket


(define (Liczba-Krokow-arc D N Przyblizenie x)
  (define (Liczba-iter An An-1 Bn Bn-1 n)
    (if (and (> n 3) (< (abs (- (/ An Bn) (/ An-1 Bn-1))) Przyblizenie))
        (- n 1)
        (Liczba-iter (+ (* An (D n)) (* An-1 (N n x))) An (+ (* Bn (D n)) (* Bn-1 (N n x))) Bn (+ n 1))))
  (Liczba-iter 0 1 1 0 0))
(define (D-arc n) (- (* n 2) 1))
(define (N-arc n x) (square (* n x)))
(define (Ulamek-arc D N Przyblizenie x)
  (define (Arc-iter i n)
    (if (= i n)
        1
        (+ (D-arc i) (/ (N-arc i x) (Arc-iter (+ i 1) n)))))
  (define n (Liczba-Krokow-arc D N Przyblizenie x))
  (/ x (Arc-iter 0 n)))

(Ulamek-arc D-arc N-arc 0.1 (/ pi 4))