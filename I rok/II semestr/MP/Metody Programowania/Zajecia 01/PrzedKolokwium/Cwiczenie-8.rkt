#lang racket

(define (power-close-to b n)
  (if (> b n)
      1
      (+ 1 (power-close-to b (/ n b)))))

(power-close-to 10 999)