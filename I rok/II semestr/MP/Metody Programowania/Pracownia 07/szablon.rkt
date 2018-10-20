#lang racket

;; expressions

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * /))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op-cons op args)
  (cons op args))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (let-def? t)
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let-def-var e)
  (car e))

(define (let-def-expr e)
  (cadr e))

(define (let-def-cons x e)
  (list x e))

(define (let? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'let)
       (let-def? (cadr t))))

(define (let-def e)
  (cadr e))

(define (let-expr e)
  (caddr e))

(define (let-cons def e)
  (list 'let def e))

(define (var? t)
  (symbol? t))

(define (var-var e)
  e)

(define (var-cons x)
  x)

(define (arith/let-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith/let-expr? (op-args t)))
      (and (let? t)
           (arith/let-expr? (let-expr t))
           (arith/let-expr? (let-def-expr (let-def t))))
      (var? t)))

;; let-lifted expressions

(define (arith-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith-expr? (op-args t)))
      (var? t)))

(define (let-lifted-expr? t)
  (or (and (let? t)
           (let-lifted-expr? (let-expr t))
           (arith-expr? (let-def-expr (let-def t))))
      (arith-expr? t)))

;; generating a symbol using a counter

(define (number->symbol i)
  (string->symbol (string-append "x" (number->string i))))
;;(number->symbol 1)

;; environments (could be useful for something)

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

;; the let-lift procedure
(define (inc x)
  (+ x 1))

;; w definicji muszą iść na lewo,bo moga byc wykorzystane w obecnym
;; w wyrażeniu, muszą iść na prawo, bo mogą potrzebować obecnego 
;; jeśli jest operator arytmetyczny, to wyszarczy że ustawię je niezależnie od siebie
;; po kolei
;; jeśli liczba -> zwracam liczbę
;; jeśli zmienna -> znajduję jej wartość w środowisku i ją zwracam

(define (tuple expr lets licznik)
  (list expr lets licznik))
(define (tuple-expr t)
  (first t))
(define (tuple-lets t)
  (second t))
(define (tuple-licznik t)
  (third t))
(define (tuple-merge t1 t2)
  (tuple (cons (tuple-expr t1)
               (tuple-expr t2))
         (append (tuple-lets t1)
                 (tuple-lets t2))
         (max (tuple-licznik t1)
              (tuple-licznik t2))))
(define (tuple-add-op op t)
  (tuple (cons op (tuple-expr t))
         (tuple-lets t)
         (tuple-licznik t)))
(define (tuple-add-let l t)
  (tuple (tuple-expr t) (cons l (tuple-lets t)) (tuple-licznik t)))
(define (empty-tuple liczba)
  (tuple null null liczba))

(define (left e)
  (define (end t)
    (if (null? (tuple-lets t))
        (tuple-expr t)
        (let ((u (end (tuple (tuple-expr t)
                             (cdr (tuple-lets t))
                             0))))

          (list 'let (car (tuple-lets t)) u))))
  (define (pomoc e srodowisko licznik)
    (cond [(const? e) (tuple e null licznik)]  
          [(var? e) (tuple (find-in-env e srodowisko) null licznik)]
          [(op? e) (tuple-add-op (op-op e)
                                 (foldr (lambda (x accu) (tuple-merge (pomoc x srodowisko (tuple-licznik accu)) accu))
                                        (empty-tuple licznik) (op-args e)))]
  
          [(let? e) (let* ([new-def-var (number->symbol licznik)]
                           [new-let-def-expr (pomoc (let-def-expr (let-def e))
                                                    srodowisko
                                                    (+ licznik 1))]
                           [new-let-expr (pomoc (let-expr e)
                                                (add-to-env (let-def-var (let-def e)) new-def-var srodowisko)
                                                (tuple-licznik new-let-def-expr))])
                      (tuple (tuple-expr new-let-expr)
                             (append (tuple-lets new-let-def-expr)
                                     (cons (list new-def-var (tuple-expr new-let-def-expr))
                                           (tuple-lets new-let-expr)))
                             (tuple-licznik new-let-expr)))]))
                                                             
  (end (pomoc e null 0))
  ;;(pomoc e null 0)
  )

(display "Z Treści\n")
(left '(+ 10 (* (let (x 7) (+ x 2)) 2)))
(let-lifted-expr? (left '(+ 10 (* (let (x 7) (+ x 2)) 2))))
(left '(let (x (- 2 (let (z 3) z))) (+ x 2)))
(let-lifted-expr? (left '(let (x (- 2 (let (z 3) z))) (+ x 2))))
(left '(+ (let (x 5) x) (let (x 1) x)))
(let-lifted-expr? (left '(+ (let (x 5) x) (let (x 1) x))))

(display "MOJE\n")
(left '(+ (* 1 2) (- 3 4)))
;;(end (left '(+ (* 1 2) (- 3 4))))
(display "\n")
(left '(let (x (let (x 5) 6)) (+ (let (x 3) x) 2)))
;;(end (left '(let (x (let (x 5) 6)) (+ (let (x 3) x) 2))))
(display "\n")
(left '(let (x 1) (let (x 2) 3)))
;;(end (left '(let (x 1) (let (x 2) 3))))
(display "\n")
(left '(let (x (let (x 5) x)) x))
;;(end (left '(let (x (let (x 5) x)) x)))






       


















                          