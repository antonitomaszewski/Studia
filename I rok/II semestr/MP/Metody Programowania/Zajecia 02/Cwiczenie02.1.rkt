#lang racket

(define (fibi x)
  (if (= x 1)
      1
      (+ (fibi (/ x 2)) (fibi (/ x 2)))))

(fibi 1024)

(define (fib n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else    (+ (fib (- n 1)) (fib (- n 2)))]))

(fib 6)

(define (square x) (* x x))
(define (inc n) (+ 1 n))

(define (compose f1 f2)
  (lambda (x)
    (f1 (f2 x))))

((compose square inc) 5) ;;
                                  