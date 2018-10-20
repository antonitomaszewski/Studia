#lang racket

(define a 1)
(define b 2)

(list a b)
(list 'a 'b)
(list 'a b)

(car '(a b c))
(cdr '(a b c))

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))
(memq 'apple '(pear banana prune))
(memq 'apple '(x '(apple sauce) y apple pear))

(list 'a 'b 'c)
(list a b)
'a
(list (list 'george))
(list a)
(cdr '((x1 x2) (y1 y2)))
(cadr '((x1 x2) (y1 y2)))
(pair? (cdr '(a short list)))
(memq 'red '((red shoes) (blue socks)))
(memq 'red '(red shoes blue socks))

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))

(define (equal?01 x y)
  (if (not (or (pair? x) (pair? y)))
      (if (eq? x y)
          #t
          #f)
      (if (and (list? x)
               (list? y)
               (eq? (car x) (car y))
               (equal? (cdr x) (cdr y)))
          #t
          #f)))
(equal?01 '(this is a list) '(this is a list))

(car ''abrakadabra)
(cdr ''abrakadabra)
(list? ''abrakadabra)
(pair? ''abrakadabra)
