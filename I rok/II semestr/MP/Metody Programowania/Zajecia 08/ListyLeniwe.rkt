#lang racket

(define (lcons x f)
  (cons x f))

(define (lhead l)
  (car l))

(define (ltail l)
  ((cdr l)))

(define (nats-from m)
  (lcons
   m
   (lambda () (nats-from (+ m 1)))))
;; ((lambda () (nats-from (+ m 1)) zapetla sie

(define nats
  (nats-from 0))

(define (take n l)
  (if (or (null? l) (= n 0))
      null
      (cons (lhead l)
            (take (- n 1) (ltail l)))))

(define (filter p l)
  (cond [(null? l) null]
        [(p (lhead l))
         (lcons (lhead l)
                (lambda ()
                  (filter p (ltail l))))]
        [else (filter p (ltail l))]))

(define (prime? n)
  (define (div-by m)
    (cond [(= m n) true]
          [(= (modulo n m) 0) false]
          [else (div-by (+ m 1))]))
  (if (< n 2)
      false
      (div-by 2)))


(nats-from 10)
(define (fib n)
  (define (pomoc i a b)
    (if (= i n)
        b
        (pomoc (+ i 1) b (+ a b))))
  (pomoc 0 1 0))
(fib 7)
(define (iter n f)
  (define (pomoc i)
    (if (= i n)
        null
        (cons (f i) (pomoc (+ i 1)))))
  (pomoc 0))
;;(iter 100 fib)
(define (fib-from n)
  (lcons
   (fib n)
   (lambda () (fib-from (+ n 1)))))
(take 10 (fib-from 0))

(define (ints-from n)
  (define (pom n)
    (lcons
     (lcons
      n
     (* (+ n 1) -1))
     (lambda () (pom (+ n 1)))))
  (pom n))
(take 10 (ints-from 1))


(define (ints n)
  (define (ints+ k)
    (lcons
     k
     (lambda () (ints+ (+ k 1)))))
  (define (ints- k)
    (lcons
     k
     (lambda () (ints- (- k 1)))))
  (lcons
   (car )))
;;(take 10 (ints 1))
(define (allints n)
  (if (= (remainder n 2) 0)
      (lcons
       (/ n -2)
       (lambda () (allints (+ n 1))))
      (lcons
       (/ (+ n 1) 2)
       (lambda () (allints (+ n 1))))))
(take 10 (allints 0))

(define (fibi-from n)
  (define (pomoc a b)
    (lcons
     b
     (lambda () (pomoc (+ a b) a))))
  (define (od i a b)
    (if (= i n)
        (pomoc a b)
        (od (+ i 1) (+ a b) a)))
  (od 0 1 0))
(take 10 (fibi-from 0))

(define (lappend xs ys)
  (if (null? xs)
      ys
      (lcons
       (lhead xs)
       (lambda () (lappend (ltail xs) ys)))))
(lappend (lcons 0 null) nats)
(define (lmap f . X)
  (if (ormap null? X)
      null
      (lcons
       (apply f (map lhead X))
       (lambda () (apply lmap (cons f (map ltail X)))))))
(lmap + '(1 2 3) '(4 5 6) '(7 8 9))
#|(define intss
  (let ((f
         (lambda (a) ()))
    (lmap f nats))))|#
(define fibss
  (lcons 1
         (lambda () (lcons 1 (lambda () (lmap + fibss (ltail fibss)))))))
(take 10 fibss)
fibss
