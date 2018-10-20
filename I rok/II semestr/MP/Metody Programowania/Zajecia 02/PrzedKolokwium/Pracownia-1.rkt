#lang racket

(define (ile N D)
  (define (iter  A A-1 B B-1 K dist)
    (if (and (> K 1)(< (abs (- (/ A-1 B-1)(/ A B))) dist))
        K
        (iter (+ (* (D K) A)
                 (* (N K) A-1))
              A
              (+ (* (D K) B)
                 (* (N K) B-1))
              B
              (+ K 1)
              dist)))
  (iter 0 1 1 0 0 0.0001))
(ile (lambda (x) 1) (lambda (x) 1))

(define (cont-frac znak num den)
  (define k (ile num den))
  (define (iter i)
    (if (= i k)
        (/ (num i) (den i))
        (/ (num i) (znak (den i) (iter (+ i 1))))))
  (iter 1))

(cont-frac + (lambda (x) 1.0) (lambda (x) 1))
  