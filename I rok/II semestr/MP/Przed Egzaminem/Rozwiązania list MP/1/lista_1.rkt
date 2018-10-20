#lang racket

;;zadanie 4

(define (sum-of-square a b c)
  (cond [(and (<= a b) (< a c)) (+ (* b b) (* c c))]
        [(and (<= b a) (<= b c)) (+ (* a a) (* c c))]
        (else
         (+ (* b b) (* a a)))))

(sum-of-square 4 5 6)
(sum-of-square 5 4 6)
(sum-of-square 6 5 4)
(sum-of-square 6 4 5)
(sum-of-square 4 6 5)
(sum-of-square 5 6 4)

(define (inc x)
  (+ x 1))

(define (power-close-to x n) 
  (define (power-close-iter x y n)
    (if (> (expt x y) n) y
        (power-close-iter x (inc y) n)))
  (power-close-iter x 0 n))

(power-close-to 3 12312)
(power-close-to 10 999)
(power-close-to 2 16)
(power-close-to 12 0)
  