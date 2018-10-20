#lang racket

(define (cont-frac znak num den k)
  (define (iter i)
    (if (= i k)
        (/ (num i) (den i))
        (/ (num i) (znak (den i) (iter (+ i 1))))))
  (iter 1))

(cont-frac + (lambda (x) 1.0) (lambda (x) 1) 100)

(define (cont-frac-iter znak num den k)
  (define (iter val k)
    (if (= k 0)
        val
        (iter (/ (num k) (+ (den k) val)) (- k 1))))
  (iter 0 k))

(cont-frac + (lambda (x) (* 1.0 x x)) (lambda (x) x) 1000) ;; ta funkcja to 1/fi * liczba iteracji!!! jednak nie był błąd używałem k a nie i w obliczaniu wartośći
(cont-frac + (lambda (x) (* 1.0 x x)) (lambda (x) (* x x)) 10)
(cont-frac + (lambda (x) (* 1.0 x)) (lambda (x) (* x x)) 100)

(cont-frac-iter + (lambda (x) 1.0) (lambda (x) 1) 100)