#lang racket
(define (abs x) (if (> x 0) x (* x -1)))
(define (dist x y) (abs (- x y)))

(define (make-vect p1 p2) (cons p1 p2))
(define (vect-begin v) (car v))
(define (vect-end v) (cdr v))
(define (vect? v) (and (pair? v) (point? (vect-begin v)) (point? (vect-end v))))
(define (make-point x y) (cons x y))
(define (point-x p) (car p))
(define (point-y p) (cdr p))
(define (point? p) (and (pair? p) (number? (point-x p)) (number? (point-y p))))

(define (vect-length v) (sqrt (+ (sqr (dist (point-x (vect-begin v))
                                            (point-x (vect-end v))))
                                 (sqr (dist (point-y (vect-begin v))
                                            (point-y (vect-end v)))))))
(define (vect-scale v k) (make-vect (vect-begin v)
                                    (make-point (+ (point-x (vect-begin v))
                                                   (* k (- (point-x (vect-end v))
                                                           (point-x (vect-begin v)))))
                                                (+ (point-x (vect-begin v))
                                                   (* k (- (point-x (vect-end v))
                                                           (point-x (vect-begin v))))))))
(define (vect-translate v p) (make-vect p
                                        (make-point (+ (point-x p) (- (point-x (vect-end v))
                                                                      (point-x (vect-begin v))))

                                                    (+ (point-y p) (- (point-y (vect-end v))
                                                                      (point-y (vect-begin v)))))))
                                                      
