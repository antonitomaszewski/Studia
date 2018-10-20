#lang racket

(define (kwadrat x) (* x x))

(define (suma-kwadratow x y)
  (+ (kwadrat x) (kwadrat y)))

(define (wieksza x y)
  (if (> x y) x y))

(define (dwie-wieksze x y z)
  (if (= (wieksza x y) x)
      (if (= (wieksza y z) y) (suma-kwadratow x y) (suma-kwadratow x z))
      (if (= (wieksza x z) x) (suma-kwadratow x y) (suma-kwadratow y z))))

(dwie-wieksze 7 1 3)
  
  

