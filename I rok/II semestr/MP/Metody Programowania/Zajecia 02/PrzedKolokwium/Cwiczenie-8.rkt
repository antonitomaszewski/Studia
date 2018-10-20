#lang racket

(define (cont-frac-rec znak num den k x)
  (define (iter i)
    (if (= i k)
        (/ (num i x) (den i x))
        (/ (num i x) (znak (den i x) (iter (+ i 1))))))
  (iter 1))
(define (cont-frac-iter znak num den k x)
  (define (iter val k)
    (if (= k 0)
        val
        (iter (/ (num k x) (znak (den k x) val)) (- k 1))))
  (iter 0 k))
(display "atg(x)==")
(cont-frac-rec +
               (lambda (k x) (if (= k 1) x
                                 (* (- k 1) (sqr x))))
               (lambda (k x) (- (* 2.0 k) 1)) 100 1)
(display "atg(1) == (/ pi 4)")
(/ pi 4)
(define (atg-cf x k)
  (define (cont-frac-rec znak num den k)
    (define (iter i)
      (if (= i k)
          (/ (num i) (den i))
          (/ (num i) (znak (den i) (iter (+ i 1))))))
    (iter 1))
  