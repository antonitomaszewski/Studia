#lang racket

;; arithmetic expressions

(define (const? t) ;;stala wartosc
  (number? t))

(define (binop? t) ;;trzy elementy: znak + dwie 'liczby'?
  (and (list? t)
       (= (length t) 3)
       (member (car t) '(+ - * /)))) ;;member == if a in b

(define (binop-op e) ;;operator tego drzewa
  (car e))

(define (binop-left e) ;;lewa wartosc
  (cadr e))

(define (binop-right e) ;;prawa wartosc
  (caddr e))

(define (binop-cons op l r) ;;tworze drzewo: lista operator lewa strona, prawa strona
  (list op l r))

(define (arith-expr? t) ;; wyrazenie arytmetyczne: liczba bądź drzewo w ktorym lewa i prawa da sie sprowadzic do liczby i potem wyliczyc
  (or (const? t)
      (and (binop? t)
           (arith-expr? (binop-left  t))
           (arith-expr? (binop-right t)))))

;; calculator

(define (op->proc op) ;;zamiana z 'operatora na dzialajacy znak 
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (eval-arith e) ;; funkcja liczaca: z wyrazenia albo liczba albo licze lewą i prawą stronę, a potem wykonuję na niej odpowiednie działanie
  (cond [(const? e) e]
        [(binop? e)
         ((op->proc (binop-op e))
            (eval-arith (binop-left  e))
            (eval-arith (binop-right e)))]))

;; let expressions

(define (let-def? t)  ;; sposob na ujęcie letów: nazwa + wyrazenie ktore sprowadzi sie do wartosci chyba
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let-def-var e) ;;nazwa 'x
  (car e))

(define (let-def-expr e) ;; wyrazenie (+ (nazwa-funkcji x y) z) costam costam
  (cadr e))

(define (let-def-cons x e) ;; tworzy przypisanie procedury e do nazwy chwilowej x
  (list x e))

(define (let? t) ;;letem jest cos jak ma identyfikator + para nazwa wyrazenie
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

(define (arith/let-expr? t) ;;polaczenie letow i wyrazen arytmetycznych
  (or (const? t)
      (and (binop? t)
           (arith/let-expr? (binop-left  t))
           (arith/let-expr? (binop-right t)))
      (and (let? t)
           (arith/let-expr? (let-expr t))
           (arith/let-expr? (let-def (let-def-expr t))))
      (var? t)))

;; evalation via substitution

(define (subst e x f)
  (cond [(const? e) e]
        [(binop? e)
         (binop-cons
           (binop-op e)
           (subst (binop-left  e) x f)
           (subst (binop-right e) x f))]
        [(let? e)
         (let-cons
           (let-def-cons
             (let-def-var (let-def e))
             (subst (let-def-expr (let-def e)) x f))
           (if (eq? x (let-def-var (let-def e)))
               (let-expr e)
               (subst (let-expr e) x f)))]
        [(var? e)
         (if (eq? x (var-var e))
             f
             (var-var e))]))

(define (eval-subst e)
  (cond [(const? e) e]
        [(binop? e)
         ((op->proc (binop-op e))
            (eval-subst (binop-left  e))
            (eval-subst (binop-right e)))]
        [(let? e)
         (eval-subst
           (subst
             (let-expr e)
             (let-def-var (let-def e))
             (eval-subst (let-def-expr (let-def e)))))]
        [(var? e)
         (error "undefined variable" (var-var e))]))

;; evaluation via environments

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

(define (eval-env e env)
  (cond [(const? e) e]
        [(binop? e)
         ((op->proc (binop-op e))
            (eval-env (binop-left  e) env)
            (eval-env (binop-right e) env))]
        [(let? e)
         (eval-env
           (let-expr e)
           (env-for-let (let-def e) env))]
        [(var? e) (find-in-env (var-var e) env)]
        [(if-zero? e)
         (if (= (eval (if-zer-cond e) env) 0)
             (eval (if-zero-true e))
             (eval (if-zezro-false e)))]))


(define (env-for-let def env)
  (add-to-env
    (let-def-var def)
    (eval-env (let-def-expr def) env)
    env))

(define (eval e)
  (eval-env e empty-env))


;;Zadanie1


(define (arith->rpn e)
  (if (const? e)
      (list e)
      (append (arith->rpn (binop-left e)) (append (arith->rpn (binop-right e)) (list (binop-op e))))))

(define a (list '+ (list '* (list '- (list '/ 1 2) 3) 4) (list '+ 5 6)))

(define (arith->rpn01 e)
  (define (pomoc e wynik)
    (if (const? e)
        (cons e wynik)
        (pomoc (binop-left e) (pomoc (binop-right e) (cons (binop-op e) wynik)))))
  (pomoc e null))
(arith->rpn a)
(arith->rpn01 a)
(define a1 (list '- a a))
(arith->rpn a1)
(arith->rpn01 a1)


;; Zadanie2
(define (ok? x)
  (or (number? x)
      (and (symbol? x)
           (member x '(+ - * /)))))
(define (operator? x)
  (not (eq? (member x '(+ - * /)) #f)))
(define (liczba? x)
  (number? x))
(define (push a x)
  (cons a x))
(define (stack? x)
  (and (list? x)
       (if (= (length x) 1)
           (ok? x)
           (and (ok? x) (stack? (cdr x))))))
(define (pop x) x)

;;Zadanie3
(define (eval-rpn e)
  (define (pomoc e wynik)
    (if (null? e)
        (car wynik)
        (if (symbol? (car e))
            (pomoc (cdr e) (cons
                            ((op->proc (car e)) (cadr wynik) (car wynik))
                            (cddr wynik)))
            (pomoc (cdr e) (cons (car e) wynik)))))
  (pomoc e null))
(eval-rpn '(1 2 / 3 - 4 * 5 6 + + 1 2 / 3 - 4 * 5 6 + + -))
(eval-rpn '(1 2 +))
(eval-rpn '(1 2 3 + +))
(eval-rpn '(1 2 * 2 +))
(eval-rpn '(1 2 / 3 - 4 * 5 6 + +))
(eval-rpn '(2 2 2 2 2 * * * * 2 2 2 2 2 * * * * *))
(eval-rpn '(1 2 /))
(eval-rpn '(2 1 /))

;;Zadanie4 bo chcemy miec wieloargumentowe operatory
;;Zadanie5
(define (tagged-list? tag x)
  (and (pair? x)
       (eq? (car x) tag)
       (list? (cdr x))))
(define (tagged-tuple? tag len x)
  (and (list? x)
       (= len (length x))
       (eq? (car x) tag)))
(define (if-zero? e)
  (and (list? e)
       (= (length e) 4)
       (eq? (first e) 'if-zero))) 
(define (if-zero e wt wf)
  (if (= e 0)
      wt
      wf))

(eval '(if-zero (- 2 2) 7 9))
(if-zero (- 2 2) 7 9)
(if-zero (let ((x 3)) x) 7 (+ 1 2))
;;(if-zero 0 1 (/ 5 0)) ;;gorliwa -- chce odrazu wiedziec z czym ma do czynienia, więc dzieli przez zero
(if-zero 0 1 0)

;;Zadanie6 - wieloargumentowe wyrazenia

"
(define (binop? t) ;;trzy elementy: znak + dwie 'liczby'?
  (and (list? t)
       (> (length t) 2)
       (member (car t) '(+ - * /))))
"
w ewalu:
[(binop? e)
 (apply (op->proc (binop-op e)))
 (map (lambda (a)
        (eval-env a env))
      (binop-args e))]
(define (binop-cons op args)
  (cons op args))

;;Zadanie7

(define (env-for-let def env)
  (if (null? def)
      env
      (env-for-let (cdr def)
                   (add-to-env
                    (let-def-var (car def))
                    (eval-env (let-def-expr (car def)) env)
                    env))))
(let ((drs (map (lambda (def)
                  (lisy (car def) (eval-env (cadr def) env)))
                defs)
          ))
  (add-to-env* drs env))

  




                                 
            


        