#lang racket

(define (full-eval? f)
  (define values (gen-vals (free-vars f)))
  (define (eval values)
    (cond ((eq? #f (eval-form f (car values))) (car values))
          ((= 1 (length values)) #f)
          (else (eval (cdr values)))))
  (eval values))

(define (falsifies? val fi)
  (if (eval-form fi val)
      #f
      val))

(first-not-false (map (lambda (val) (falsifies? val fi)) vals))

(define (ormap f xs)
  (if (null? xs)
      false
      (or (f (car xs))
          (ormap f (cdr xs)))))