#lang racket

(define (make-point x y)
  (cons x y))
(define (point-x p)
  (car p))
(define (point-y p)
  (cdr p))
(define (point? p)
  (and (pair? p) (number? (point-x p)) (number? (point-y p))))


(define (make-vect p k l)
  (cons p (cons k l)))

(define (vect-point v)
  (car v))
(define (vect-angle v)
  (car (cdr v)))
(define (vect-length v)
  (cdr (cdr v)))
(define (vect? v)
  (and (point? (vect-point v))
       (and (>= (vect-angle v) 0) (< (vect-angle v) (* 2 pi)))
       (number? (vect-length v))))
(define (vect-scale v k)
  (make-vect (vect-point v) (vect-angle v) (* k (vect-length v))))
(define (vect-translate v p)
  (make-vect p (vect-angle v) (vect-length v)))
(define (vect-begin v)
  (car v))
(define (vect-end v)
  (make-point (+ (point-x (vect-begin v)) (* (vect-point v) (sin (vect-angle v))))
              (+ (point-y (vect-begin v)) (* (vect-point v) (cos (vect-angle v))))))

(define v (make-vect (make-point 1 1) (/ pi 4) 10))
v
(vect-point v)
(vect-angle v)
(vect-length v)
(vect? v)
(vect-begin v)
(vect-end v)
(define v1 (vect-scale v 5))
(define v2 (vect-translate v (make-point 0 0)))
v1
v2
