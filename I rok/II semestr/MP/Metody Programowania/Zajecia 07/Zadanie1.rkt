#lang racket

(define (f)   ;;funkcja jest jakby bezargumentowa, dodaje 10
  (let ([y 10])  ;; na szybko tworzy nową zmienną y=10
    (lambda (x) (+ x y)))) ;; tworzymy nową zmienną x, którą poda użytkownik

(define y 0)

((f) 5)

(