#lang racket
(define (power-close-to b n e)
  (if (> (expt b e) n)
      e
      (power-close-to b n (+ e 1))))

(power-close-to 2 17 0)


(define (najmniejsza-potega b n)
  (define (najmniejsza-potega1 b n e)
    (if (> (expt b e) n)
        e
        (najmniejsza-potega1 b n (+ 1 e))))
  (if (or (and (> 1 b) (< 0 b) (<= 1 n))
          (= 1 b n))
      #f
      (najmniejsza-potega1 b n 0)))

(najmniejsza-potega 2 1000)