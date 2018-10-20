#lang racket

;;(define (licznik numer) ())
;;(define (mianownik numer) ())

;;(define (Fk Ak Bk) ())

(define (square x) (* x x))

(define (cont-frac licznik mianownik k)
  (define (helper licznik mianownik k i)
    (if (= i k)
        0
        (/ (licznik i) (+ (mianownik i) (helper licznik mianownik k (+ i 1))))))
  (helper licznik mianownik k 0))


(define (licznik k) 1.0)
(define (mianownik k) 1)

;;(cont-frac licznik mianownik 25)

(define (arc-licznik k x) (* (square k) (square x)))
(define (arc-mianownik k x) (- (* 2 k) 1))

(define (Ak licznik mianownik)
  (define (Ak-iter An-1 An-2 i)
    (+ (* (mianownik i) An-1) (* (licznik i) An-2)))
  (Ak-iter 0 1 1))

(define (D n) 1.0)
(define (N n) 1.0)

(define (Good An An-1 An-2 Bn Bn-1 Bn-2 n good-enough?)
  (if (and (> n 2) (< (abs (- (/ An Bn) (/ An-1 Bn-1))) good-enough?))
      n
      (Good (+ (* An (D n)) (* An-1 (N n))) An An-1 (+ (* Bn (D n)) (* Bn-1 (N n))) Bn Bn-1 (+ n 1) good-enough?)))

(Good 0 1 0 1 0 0 0 0.01)

(cont-frac N D 1)
(cont-frac N D 5)
(cont-frac N D 6)
(cont-frac N D 7) ;; jesli zwaraca 9 to znaczy ze miedzy 8 a 9 jest chujowo a miedzy 9 a 10 juz ok
(cont-frac N D 8)
(cont-frac N D 9)
(Good 0 1 0 1 0 0 0 0.000001)
(- (cont-frac N D 5)
(cont-frac N D 6))
