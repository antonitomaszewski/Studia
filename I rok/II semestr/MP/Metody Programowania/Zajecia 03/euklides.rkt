#lang racket
(define (NWD a b)
  (if (= b 0)
      a
      (NWD b (modulo a b))))


;;para -> para
(define (EUK a)
  (define b (cdr a))
  (define A (car a))
  (if (= b 0) 
      (cons 1 0)
      (if (< b A)
      (let ((p (EUK(cons b (modulo A b)))))
        (cons (cdr p) (- (car p) (* (/ (- A (modulo A b)) b) (cdr p)))))
      (let ((p (EUK(cons A (modulo b A)))))
        (cons (cdr p) (- (car p) (* (/ (- b (modulo b A)) A) (cdr p)))))
      )))

(define (solve-ax+by=1 a b)
  (cdr (EUK (cons a b))))

(solve-ax+by=1 10 3)

(solve-ax+by=1 10 3)
(solve-ax+by=1 (* 17 19) 5)
(solve-ax+by=1 3233 17)