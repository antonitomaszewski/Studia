#lang racket


(define (cubic-root x)
  (define (cube a) (* a a a))
  (define (abs a) (if (> a 0) a (- 0 a)))
  (define (dist a b) (abs (- a b)))
  (define (good-enough? approx)
     (< (dist x (cube approx)) 0.0000001))
   (define (better approx)
     (/ (+ (/ x (* approx approx)) (* 2 approx)) 3))
   (define (next-iteration approx)
     (if (good-enough? approx)
         approx
         (next-iteration (better approx))))
   (next-iteration 1.0))

(cubic-root 8)
(cubic-root -8)
(cubic-root 27)
(cubic-root -27)
(cubic-root 1000)
(cubic-root -1000)
(cubic-root 0)
(cubic-root -0)
(cubic-root (expt 1000 (- 5)))
(cubic-root (/ 1 1000))
(cubic-root (- 0 (/ 1 1000)))
(cubic-root 0.027)
(cubic-root -0.125)
(cubic-root (/ 27 64))
(cubic-root (/ -27 64))
(cubic-root (/ (* 99 99 99) (* 100 100 100)))
(cubic-root (/ (* 99 99 99) (* -100 100 100)))
(cubic-root (/ (* 999 999 999) (* 1000 1000 1000)))
(cubic-root (/ (* 999 999 999) (* -1000 1000 1000)))
(cubic-root 1)
(cubic-root -1)

;;gdy strasznie blisko jedynki to dla ujemnych gorzej, w pozostalych dla ujemnych lepiej

   
    