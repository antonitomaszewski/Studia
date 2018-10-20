#lang racket
 
(define (dist x y)
  (abs (- x y)))
 
(define (compose f g)
  (lambda (x) (f (g x))))
 
(define (repeated f n)
  (if (= n 0) identity
      (compose f (repeated f (- n 1)))))
 
(define (good-enough? x y)
  (< (dist x y) 0.0001))
 
(define (fixed-point f x0)
  (let ((x1 (f x0)))
    (if (good-enough? x0 x1)
        x0
        (fixed-point f x1))))
 
(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))
 
(define (number-of-damp n)
  (define (log2 a k)
    (if(> a n)
       (- k 1)
       (log2 (* a 2) (+ k 1))))
  (if (= n 1)
     1
     (log2 1 0)))

(number-of-damp 7)


 
(define (nth-root x n)
  (fixed-point
   ((repeated average-damp (number-of-damp n))
    (lambda (y) (/ x (expt y (- n 1)))))
             1.0))
 
(nth-root 27 3)
(nth-root 16 4)
(nth-root (expt 2 7) 7)
(nth-root (expt 10 10) 10)
(nth-root 0 100000) 

;;gdy mniej niz podloga z logarytmu dwojkowego to czasem wpada w nieskonczona petle, gdy wiecej powoli stopniowo wzrasta niedokladnosc

(define (nth-root01 x n damp)
  (fixed-point ((repeated average-damp damp)
             (lambda (y) (/ x (expt y (- n 1)))))
             1.0))

;;(nth-root01 16 4 1) ;; nieskonczona petla
(nth-root01 16 4 2) 

(nth-root01 1000000 6 1) ;;tu dziala
(nth-root01 1000000 6 2)

(nth-root01 (expt 5 9) 9 3)
;;(nth-root01 (expt 5 9) 9 2) ;; nieskonczona petla

(define x (if (= 1 1)
              1
              0))
x
