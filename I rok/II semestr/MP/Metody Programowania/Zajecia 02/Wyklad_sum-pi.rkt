#lang racket

(define (sum-pi n e)
  (if (> n e)
      0
      (+ (/ 1 (* n (+ n 2))) (sum-pi (+ n 4) e))))

(sum-pi 3 5)
(sum-pi 3 6)
(sum-pi 3 7)
(sum-pi 3 8)
;;(sum-pi 1 x naturalny) ~ 0.38 
