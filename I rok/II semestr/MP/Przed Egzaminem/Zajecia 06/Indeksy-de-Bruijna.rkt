#lang racket

(apply append '((1) (1 2 )))
((λ () 1))


(define (let? e)
  (and (list? e)
       (= (length e) 3)
       (eq? (car e) 'let)))
(define (var? e)
  (symbol? e))

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))
(define (op? e)
  (and (list? e)
       (member (car e) '(+ - / *))))
(define (convert-to-db e i env)
  (cond [(let? e)
         (let [(new-env (add-to-env (caadr e) (list 'index i) env))]
           (let [(def-var (convert-to-db (cadadr e) (+ i 1) new-env))
                 (expr (convert-to-db (caddr e) (+ i 1) new-env))]
         (cons (list 'let (car def-var) (car expr)) (cdr expr))))]
        [(var? e)
         (cons (find-in-env e env) i)]
        [(number? e) (cons e i)]
        [(op? e)
         (let* [(left (convert-to-db (cadr e) i env))
                (right (convert-to-db (caddr e) (cdr left) env))]
         (cons (list (car e) (car left) (car right)) (cdr right)))
                               ]))

;; w miare dobrze, nie dziala dla wielu argumentów operatora, trzeba byłoby dać przekazywa wartość indeksu, robiliśmy to już z letami 
(convert-to-db '(let (x (let (y 2) (+ y 1))) (+ x x)) 0 empty-env)
(convert-to-db '(let (x (let (y 2) 3)) (+ x x)) 0 empty-env)
(convert-to-db '(let (x 1) (+ x x)) 0 empty-env)

(convert-to-db '(+ (let (x 1) x) (let (x 2) x)) 0 empty-env)