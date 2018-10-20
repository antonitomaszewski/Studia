#lang racket

(define (square x) (* x x))
(define (D-fib n) 1.0)
(define (N-fib n) 1.0)

(define (Liczba-Krokow D N Przyblizenie)
  (define (Liczba-iter An An-1 Bn Bn-1 n)
    (if (and (> n 1) (< (abs (- (/ An Bn) (/ An-1 Bn-1))) Przyblizenie))
        (- n 1)
        (Liczba-iter (+ (* An (D n)) (* An-1 (N n))) An (+ (* Bn (D n)) (* Bn-1 (N n))) Bn (+ n 1))))
  (Liczba-iter 0 1 1 0 0))

(define (Ulamek D N Przyblizenie)
  (define (Ulamek-iter i n)
    (if (= i n)
        0
        (/ (N i) (+ (D i) (Ulamek-iter (+ i 1) n)))))
  (define n (Liczba-Krokow D N Przyblizenie))
  (Ulamek-iter 0 n))

(Liczba-Krokow D-fib N-fib 0.0001)
(Ulamek D-fib N-fib 0.0001)



(define (N-pi n) (square (- (* n 2) 1)))
(define (D-pi n) 6)

(define (Ulamek-pi D N Przyblizenie)
  (define (Pi-iter i n)
    (if (= i n)
        0
        (/ (N-pi i) (+ (D-pi i) (Pi-iter (+ i 1) n)))))
  (define n (Liczba-Krokow D N Przyblizenie))
  (+ 3.0 (Pi-iter 0 n)))

(Ulamek-pi D-pi N-pi 0.001)

          