#lang racket

;; ten plik zawiera predykaty opisujące elementy składni abstrakcyjnej
;; naszego języka: to, co było na wykładzie oraz kilka elementów, które
;; dodawaliśmy na ćwiczeniach.

;; pomocnicza funkcja dla list tagowanych o określonej długości

(define (tagged-tuple? tag len p)
  (and (list? p)
       (= (length p) len)
       (eq? (car p) tag)))

(define (tagged-list? tag p)
  (and (pair? p)
       (eq? (car p) tag)
       (list? (cdr p))))

;; self-evaluating expressions

(define (const? t)
  (or (number? t)
      (my-symbol? t)
      (eq? t 'true)
      (eq? t 'false)))

;; arithmetic expressions

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= eq?))))

;; symbols

(define (my-symbol? e)
  (and (tagged-tuple? 'quote 2 e)
       (symbol? (second e))))

;; lets

(define (let-def? t)
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let? t)
  (and (tagged-tuple? 'let 3 t)
       (let-def? (cadr t))))

;; variables

(define (var? t)
  (symbol? t))

;; pairs

(define (cons? t)
  (tagged-tuple? 'cons 3 t))

(define (car? t)
  (tagged-tuple? 'car 2 t))

(define (cdr? t)
  (tagged-tuple? 'cdr 2 t))

(define (pair?? t)
  (tagged-tuple? 'pair? 2 t))

;; if

(define (if? t)
  (tagged-tuple? 'if 4 t))

;; cond

(define (cond-clause? t)
  (and (list? t)
       (= (length t) 2)))

  (define (cond? t)
  (and (tagged-list? 'cond t)
       (andmap cond-clause? (cdr t))))

;; lists

(define (my-null? t)
  (eq? t 'null))

(define (null?? t)
  (tagged-tuple? 'null? 2 t))

;; lambdas

(define (lambda? t)
  (and (tagged-tuple? 'lambda 3 t)
       (list? (cadr t))
       (andmap symbol? (cadr t))))

;; lambda-rec

(define (lambda-rec? t)
  (and (tagged-tuple? 'lambda-rec 3 t)
       (list? (cadr t))
       (>= (length (cadr t)) 1)
       (andmap symbol? (cadr t))))

;; applications

(define (app? t)
  (and (list? t)
       (> (length t) 0)))



