#lang racket



(define (D n) 1.0)
(define (N n) 1.0)
(define (Good An An-1 Bn Bn-1 n good-enough? D N)
  (if (and (> n 2) (< (abs (- (/ An Bn) (/ An-1 Bn-1))) good-enough?))
      n
      (Good (+ (* An (D n)) (* An-1 (N n))) An (+ (* Bn (D n)) (* Bn-1 (N n))) Bn (+ n 1) good-enough? D N)))

(Good 0 1 1 0 0 0.01 D N)


(define (Liczba-Krokow D N Przyblizenie)
  (define (Liczba-iter An An-1 Bn Bn-1 n)
    (if (and (> n 1) (< (abs (- (/ An Bn) (/ An-1 Bn-1))) Przyblizenie))
        n
        (Liczba-iter (+ (* An (D n)) (* An-1 (N n))) An (+ (* Bn (D n)) (* Bn-1 (N n))) Bn (+ n 1))))
  (Liczba-iter 0 1 1 0 0))

(define (Ulamek D N Przyblizenie)
  (define (Ulamek-iter i n)
    (if (= i n)
        0
        (/ (N i) (+ (D i) (Ulamek-iter (+ i 1) n)))))
  (define n (Liczba-Krokow D N Przyblizenie))
  (Ulamek-iter 0 n))

(Liczba-Krokow D N 0.01)
(Ulamek D N 0.01)