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

(define (average a b) (/ (+ a b) 2))
 
(define (average-damp f)
  (lambda (x) (average (f x) x)))


(define (log n)
  (lambda (a k)
    (if (> a n)
      k
      ((log n) (* a 2) (+ k 1)))))
;;((log 4) 1 -1)
;;((log 7) 1 -1)
  
(define (nth-root x n)
  (define damps (if (= n 1)
                    1
                    ((log n) 1 -1)))
  (fixed-point ((repeated average-damp damps)
                (lambda (y) (/ x (expt y (- n 1))))) 1.0))

(nth-root 8 3)
(nth-root (expt 5 10) 10)
(nth-root (expt 3 7) 7)
(nth-root (expt 10 15) 15)
(nth-root (expt 1 10) 10)
;;gdy mniej niz podloga z logarytmu dwojkowego to czasem wpada w nieskonczona petle, gdy wiecej powoli stopniowo wzrasta niedokladnosc

(define (nth-root01 x n damps)
   (fixed-point ((repeated average-damp damps)
                (lambda (y) (/ x (expt y (- n 1))))) 1.0))

;;(nth-root01 16 4 1) ;; nieskonczona petla
(nth-root01 16 4 2) 

(nth-root01 1000000 6 1) ;;tu dziala
(nth-root01 1000000 6 2)

(nth-root01 (expt 5 9) 9 3)
;;(nth-root01 (expt 5 9) 9 2) ;; nieskonczona petla

(nth-root01 (expt 9 20) 20 4)
;;(nth-root01 (expt 9 20) 20 3) ;; nieskonczona petla


  