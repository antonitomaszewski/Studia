#lang racket

;; arithmetic expressions

(define (const? t)  ;;stała == liczba
  (number? t))

(define (op? t)     ;;operacja == lista, której pierwszym elementem jest znak działania, drugim cokolwiek
  (and (list? t)
       (member (car t) '(+ - * /))))

(define (op-op e)   ;;wyciągamy operator z wyrażenia
  (car e))

(define (op-args e) ;;wyciągamy argumenty wyrażenia (operacji arytmetycznej)
  (cdr e))

(define (op-cons op args) ;;tworzymy parę operator i argumenty
  (cons op args))

(define (op->proc op)     ;;zamiana 'znaku na znak działania
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

;; lets

(define (let-def? t)  ;;czy jest to definicja leta -- czy jest to lista, o dwóch argumentem, z których pierwszy to symbol
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let-def-var e)  ;; wyciągamy nazwę, której wprowadzamy w lecie
  (car e))

(define (let-def-expr e)  ;; wyciągamy wyrażenie, które przypisujemy do zmiennej
  (cadr e))

(define (let-def-cons x e) ;;tworzymy definicję w lecie -- para zmienna + wyrażenie
  (list x e))

(define (let? t) ;; letem się jest, gdy jest to lista 3 elementowa, w której pierwszy element to znacznik, drugi przypisanie, trzecie cokolwiek
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'let)
       (let-def? (cadr t))))

(define (let-def e)  ;;wyciągamy definicję z leta
  (cadr e))

(define (let-expr e) ;; wyciągamy wyrażenie wykonywane z leta
  (caddr e))

(define (let-cons def e) ;; tworzymy leta -- para definicja+wyrażenie wykonywane
  (list 'let def e))

;; variables

(define (var? t) ;; zmienną się jest gdy jest się symbolem
  (symbol? t))

(define (var-var e) 
  e)

(define (var-cons x)
  x)

;; pairs

(define (cons? t)  ;; consem się jest gdy jest się listą 3 elementową, znacznik='cons + 2 razy cokolwiek
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'cons)))

(define (cons-fst e)  ;; pierwszy element pary
  (second e))

(define (cons-snd e)  ;drugi element pary
  (third e))

(define (cons-cons e1 e2)  ;tworzymy consa -- lista 'cons e1 e2
  (list 'cons e1 e2))

(define (car? t)  ;; czy mamy do czynienia z pierwszym elementem znacznik='car + cokolwiek
  (and (list? t)
       (= (length t) 2)
       (eq? (car t) 'car)))

(define (car-expr e)  ;; wyrażenie cara to drugi element listy
  (second e))

(define (cdr? t)  ;; analogicznie do cara
  (and (list? t)
       (= (length t) 2)
       (eq? (car t) 'cdr)))

(define (cdr-expr e)
  (second e))

;; lambdas  

(define (lambda? t)  ;; lambdą jest wtedy gdy jest to lista, w której pierwszy element to znacznik='lambda, drugi to lista (zapewne wprowadzanych nowych zmiennych, co sprawdzamy andmapem 
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'lambda)
       (list? (cadr t))
       (andmap symbol? (cadr t))))  ;;co jest w 3 części- fragmencie wykonywanym nie jesteśmy w stanie zapytać

(define (lambda-vars e)  ;; zmienne wprowadzane w lambdzie (drugi element)
  (cadr e))

(define (lambda-expr e) ;; wyrażenie wykonywane z lambdy (trzeci element)
  (caddr e))

;; applications  funkcja + argumenty

(define (app? t)  ;;aplikacja to lista, która ma conajmniej 1 element?
  (and (list? t)
       (> (length t) 0)))

(define (app-proc e)  ;;pierwszy element aplikacji to procedura
  (car e))

(define (app-args e)  ;;drugi element aplikacji to argument (zapewne wykorzystywane w procedurze -? zaburzona kolejność w porównaniu z lambdami i letami)
  (cdr e))


;; expressions

(define (expr? t)  ;;wyrażenie to albo:
  (or (const? t)           ;; 1) stała wartość - liczba
      (and (op? t)         ;; 2) operacja, której wszystkie argumenty są dowolnymi wyrażeniami (rekurencyjne wywołanie)
           (andmap expr? (op-args t)))  
      (and (let? t)        ;; 3) let, którego wyrażenie wykonywanie spełnia warunek rekurencyjny expr oraz którego wyrażenie w przypisaniu również go spełnia
           (expr? (let-expr t))
           (expr? (let-def-expr (let-def t))))
      (var? t)             ;; 4) zmienna - symbol
      (and (cons? t)       ;; para, której obie połówki są wyrażeniami
           (expr? (cons-fst t))
           (expr? (cons-snd t)))
      (and (car? t)        ;; 5) jest jedną z połówek - carem i wyrażenie które jest w nim zawarte również spełnia predykat expr
           (expr? (car-expr t)))
      (and (cdr? t)        ;; 6) jest jedną z połówek - cdrem i wyrażenie które jest w nim zawarte również spełnia predykat expr
           (expr? (cdr-expr t)))
      (and (lambda? t)     ;; 7) lambda, której wykonanie spełnia expr
           (expr? (lambda-expr t)))
      (and (app? t)        ;; 8) aplikacja, której procedura spełnia expr oraz wszystkie z argumentów aplikacji również
           (expr? (app-proc t))
           (andmap expr? (app-args t)))))

;; environments

(define empty-env  ;; puste środowisko -- null
  null)

(define (add-to-env x v env) ;; dodajemy na początek do środowiska listę (x v) chyba x to zmienna a v to jej wartość ale może być na odwrót
  (cons (list x v) env))

(define (find-in-env x env)  ;; wyszukujemy w środowisku naszej po nazwie naszej zmiennej jej wartość, jeśli jej nie ma zwracamy błąd
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

;; closures  z angielskiego zamknięcie - prawdopodobnie chodzi o te domknięcia
;; obiekt łączący fukcję ze środowiskiem mającym wpływ na funkcję w momencie jej definiowania
(define (closure-cons xs expr env)  ;; tworzenie domknięcia -- lista znacznik='closure + lista + wyrażenie + środowisko
  (list 'closure xs expr env))

(define (closure? c)  ;; domknięcie? jest się nim wtedy i tylko w tedy, gdy jest się listą, długości 4, z czego pierwszy to znacznik 'closure
  (and (list? c)
       (= (length c) 4)
       (eq? (car c) 'closure)))

(define (closure-vars c) ;; zmienne -- lista xs, znajdująca się na drugim miejscu
  (cadr c))

(define (closure-expr c)  ;; wyrażenie -- na trzecim
  (caddr c))

(define (closure-env c)  ;środowisko, z którego korzystamy - na czwartym
  (cadddr c))


;; cwiczenie 3

(define (nullv? e)
  (or (and (list? e) (= (length e) 0)) (eq? 'null e)))
(define (null-expr? e) (and (list? e) (eq? 'null? (car e))))

(define (pairv? e)
  (and (list? e) (= 3 (length e)) (eq? 'cons (car e))))
(define (pair-expr? e) (and (list? e) (eq? 'pair? (car e))))

(define (list-expr? e)
  (and (list? e) (eq? 'list (car e))))

(define (lista e env)
  (if (null? e) 'null
      (cons-cons (eval-env (car e) env) (lista (cdr e) env)))) 

;; evaluator

(define (eval-env e env)  ;; ewaluator naszego wyrażenia, w zadanym środowisku
  (cond [(const? e) e]  ;; 1) jeśli mamy stałą to ją po prosu zwracamy
        [(op? e)        ;; 2) operacja arytmetyczna -- 
         (apply (op->proc (op-op e))  ; bierzemy operator i go stosujemy kolejno do argumentów wyrażenia
                (map (lambda (a) (eval-env a env))  ;; lambda po kolei wyciąga nam wartość zmiennej w środowisku
                     (op-args e)))]
        [(nullv? e) null]
        [(null-expr? e)
         (nullv? (eval-env (cadr e) env))]
        ;;[(pairv? e)
         
        [(pair-expr? e)
         (pairv? (cadr e))]
        [(list-expr? e) (eval-env (lista (cdr e) env) env)]
        [(let? e)       ;; 3) let obliczamy wartość wyrażenia, której nową zmienną chwilowo wprowadzamy do naszego środowiska wraz z jej wartością
         (eval-env (let-expr e)
                   (env-for-let (let-def e) env))]
        [(var? e) (find-in-env (var-var e) env)]  ;; 4) zmienna -- zwracamy jej wartość w środowisku
        [(cons? e)      ;; 5) para zwracamy parę wartośi obliczonych po lewej i prawej stronie
         (cons (eval-env (cons-fst e) env)
               (eval-env (cons-snd e) env))]
        [(car? e)       ;; 6) liczymy lewą część pary
         (car (eval-env (car-expr e) env))]
        [(cdr? e)       ;; 7) liczymy prawą część pary
         (cdr (eval-env (cdr-expr e) env))]
        [(lambda? e)    ;; 8) lambda tworzymy domknięcie składające się z kolejno zmiennych wyrażenia i naszego dotychczasowego środowiska
         (closure-cons (lambda-vars e) (lambda-expr e) env)]
        [(app? e)       ;; 9) aplikacja -- nie czaje
         (apply-closure
           (eval-env (app-proc e) env)  ;; obliczamy wartość procedury naszej aplikacji
           (map (lambda (a) (eval-env a env))
                (app-args e)))]
        
        ))

(define (apply-closure c args)
  ;;(if (null? c) null
  (eval-env (closure-expr c)
            (env-for-closure
              (closure-vars c)
              args
              (closure-env c))))

(define (env-for-closure xs vs env)
  (cond [(and (null? xs) (null? vs)) env]
        [(and (not (null? xs)) (not (null? vs)))
         (add-to-env
           (car xs)
           (car vs)
           (env-for-closure (cdr xs) (cdr vs) env))]
        [else (error "arity mismatch")]))

(define (env-for-let def env)  ;; dodajemy do środowiska zmienną z defa (letu) i wartość jej przypisaną
  (add-to-env
    (let-def-var def)  
    (eval-env (let-def-expr def) env)
    env))

(define (eval e)  ;; to będziemy wywoływać, aby obliczyć wartość wyrażenia
  (eval-env e empty-env))

(define a '(let (x 5) (lambda (z) (let (y 5) (+ x y z)))))
(eval a)

(define a1 '(let (x 5) (lambda (x) (let (y 5)(+ x y)))))
(eval a1)


#| '(closure
      (zmienna zadeklarowana, ale nie posiadająca jeszcze nadanej wartości, pochodzi z lambdy)
      (wyrażenie najbardziej w głębi, w którym zawiera się wykonanie,
         jest dosłownie przepisane z przykładu)
      ((zmienne najbardziej z lewej, z zadaną wartością)...)
|#

(define a2 '((lambda (x) (lambda (y) (+ x y))) 10))
(eval a2)

(display "MOJE\n")
(define a3 '(let (x 5) (let (x 6) (let (y 7) (+ x y)))))
(eval a3)
(define a4 '(lambda (x y) (let (x 6) (let (y 7) (+ x y)))))
(eval a4)
(define a5 '(lambda (x y) (lambda (x) (lambda (y) (+ x y)))))
(eval a5)
#|
   '(closure
        (pierwsze nie znane przez nas zmienne)
          (wszystko co potem)
         ((wartosci które poznaliśmy zanim natrafiliśmy na pierwszą niewiadomą)
|#
(define a6 '((lambda (x y) ((lambda (a) (lambda (b a) (+ x y))) 7)) 5 6))
(eval a6)
(define a7 '((lambda (x y) (lambda (a) (lambda (b) (+ x y)))) 5 6))
(eval a7)

(display "\na8\n")
(define a8 '(let (a 1) (lambda (b b1) (let (c 3) (lambda (x) (+ a b c))))))
(eval a8)

(display "\na9\n")
(define a9 '(let (x 5)
              (let (z (+ x 37))
                (lambda (x y)
                  (+ x y z)))))
(eval a9)
(apply-closure (eval a9) '(1 2))

#|(eval '(null? (1 2)))
(eval '(pair? (cons 1 2)))
(eval '(null? 1))
(eval '(null? ()))
(eval '(null? null))
(eval '(pair? ()))
;;(apply-closure '(let (x (null? null)) x) null)
(list)
(lista '(1 2 3 4 5 6 null) null)
(eval '(list 1 2 3 4 5))|#
(define q '(lambda (x) (cons 1 2)))
(eval q)
;;(apply-closure q '(0))
(eval '((lambda (x) (car x)) (cons 1 2)))
(eval '(car (lambda (x) x)))
;;trzeba zmienić car cdr cons
