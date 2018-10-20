#lang racket

;; pomocnicza funkcja dla list tagowanych o określonej długości

(define (tagged-tuple? tag len p)
  (and (list? p)
       (= (length p) len)
       (eq? (car p) tag)))

(define (tagged-list? tag p)
  (and (pair? p)
       (eq? (car p) tag)
       (list? (cdr p))))

;;
;; WHILE
;;

; memory

(define empty-mem
  null)

(define (set-mem x v m)
  (cond [(null? m)
         (list (cons x v))]
        [(eq? x (caar m))
         (cons (cons x v) (cdr m))]
        [else
         (cons (car m) (set-mem x v (cdr m)))]))

(define (get-mem x m)
  (cond [(null? m) 0]
        [(eq? x (caar m)) (cdar m)]
        [else (get-mem x (cdr m))]))

; arith and bool expressions: syntax and semantics

(define (const? t)
  (number? t))

(define (true? t)
  (eq? t 'true))

(define (false? t)
  (eq? t 'false))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= not and or mod rand r r-val car cdr r1 lambda))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]
        [(eq? op '=) =]
        [(eq? op '>) >]
        [(eq? op '>=) >=]
        [(eq? op '<)  <]
        [(eq? op '<=) <=]
        [(eq? op 'not) not]
        [(eq? op 'and) (lambda x (andmap identity x))]
        [(eq? op 'or) (lambda x (ormap identity x))]
        [(eq? op 'mod) modulo]
        [(eq? op 'rand) ;(lambda (max) (rand max))]
         (lambda (max) (min max 4))]
        [(eq? op 'r)  (lambda (x y) (rand x y))]
        [(eq? op 'r-val) rand-val]
        [(eq? op 'car) car]
        [(eq? op 'cdr) cdr]
        [(eq? op 'r1) (lambda (max) (rand1 max))]
        [else (lambda (i) (op i))]
        )) ; chosen by fair dice roll.
; guaranteed to be random.

(define (var? t)
  (symbol? t))

(define (eval-arith e m)
  (cond [(true? e) true]
        [(false? e) false]
        [(var? e) (get-mem e m)]
        [(op? e)
         (apply
          (op->proc (op-op e))
          (map (lambda (x) (eval-arith x m))
               (op-args e)))]
        [(const? e) e]))

;; syntax of commands

(define (assign? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (second t) ':=)))

(define (assign-var e)
  (first e))

(define (assign-expr e)
  (third e))

(define (if? t)
  (tagged-tuple? 'if 4 t))

(define (if-cond e)
  (second e))

(define (if-then e)
  (third e))

(define (if-else e)
  (fourth e))

(define (while? t)
  (tagged-tuple? 'while 3 t))

(define (while-cond t)
  (second t))

(define (while-expr t)
  (third t))

(define (block? t)
  (list? t))

;; state

(define (res v s)
  (cons v s))

(define (res-val r)
  (car r))

(define (res-state r)
  (cdr r))

;; psedo-random generator

(define initial-seed
  123456789)

(define (rand max i)
    (let ([v (modulo (+ (* 1103515245 i) 12345) (expt 2 32))])
      (res (modulo v max) v)))
(define (rand1 max)
  (lambda (i)
    (let ([v (modulo (+ (* 1103515245 i) 12345) (expt 2 32))])
      (res (modulo v max) v))))
    
(define (rand-val max i)
    (let ([v (modulo (+ (* 1103515245 i) 12345) (expt 2 32))])
      v))

;; WHILE interpreter

(define (old-eval e m)
  (cond [(assign? e)
         (set-mem
          (assign-var e)
          (eval-arith (assign-expr e) m)
          m)]
        [(if? e)
         (if (eval-arith (if-cond e) m)
             (old-eval (if-then e) m)
             (old-eval (if-else e) m))]
        [(while? e)
         (if (eval-arith (while-cond e) m)
             (old-eval e (old-eval (while-expr e) m))
             m)]
        [(block? e)
         (if (null? e)
             m
             (old-eval (cdr e) (old-eval (car e) m)))]))

(define (eval e m seed)
  ;; TODO : ZAD B: Zaimplementuj procedurę eval tak, by
  ;;        działała sensownie dla wyrażeń używających
  ;;        konstrukcji "rand".
  (old-eval e m))

(define (run e)
  (eval e empty-mem initial-seed))

;;

(define fermat-test
  '{} ;; TODO : ZAD A: Zdefiniuj reprezentację programu w jęzku
  ;;        WHILE, który wykonuje test Fermata, zgodnie z
  ;;        treścią zadania. Program powinien zakładać, że
  ;;        uruchamiany jest w pamięci, w której zmiennej
  ;;        n przypisana jest liczba, którą testujemy, a
  ;;        zmiennej k przypisana jest liczba iteracji do
  ;;        wykonania. Wynik powinien być zapisany w
  ;;        zmiennej comopsite. Wartość true oznacza, że
  ;;        liczba jest złożona, a wartość false, że jest
  ;;        ona prawdopodobnie pierwsza.
  )

(define (probably-prime? n k) ; check if a number n is prime using
  ; k iterations of Fermat's primality
  ; test
  (let ([memory (set-mem 'k k
                         (set-mem 'n n empty-mem))])
    (not (get-mem
          'composite
          (eval fermat-test memory initial-seed)))))

(define p empty-mem)
(set! p (set-mem 'n 10 p))
(set! p (set-mem 'k 4 p))

(define fermant
  '((k := 1)
    (n := 10)
    (while (< k 10)
           (a := (rand 2 (- n 2)))
           (b := (- n 1))
           (c := a)
           (while (< 0 b)
                  (w := (mod b 2))
                  (if (= w 0)
                      (a := (mod (* a a) n)) 
                      (a := (mod (* a c) n)))
                  (if (= w 0)
                      (b := (/ b 2))
                      (b := (- b 1))))
           (if (not (= a 1))
               (k := 11)
               (k := (+ k 1))))
    (if (= k 11)
        false
        true)))

(define fermi
  '((while (< 0 k)
           ((a := (+ 2 (rand (- n 4))))
            (b := (- n 2))
            (c := a)
            (while (< 0 b)
                   ((a := (mod (* a c) n))
                    (b := (- b 1))))
            (if (not (= a 1))
                (k := -10)
                (k := (- k 1)))))
    (if (and (= k -10) (not (= n 2)))
        (composite := false)
        (composite := true))))
(define p1 (set-mem 'k 5 (set-mem 'n 100 empty-mem)))
(eval fermi p1 1)
(define (iter i)
  (if (= i 0)
      0
      (cons (eval fermi (set-mem 'k 20 (set-mem 'n i empty-mem)) 1)
            (iter (- i 1)))))
(define sprawdzam (lambda (a n) (let f ([a1 a] [c a] [i (- n 1)])
                                  (if (= i 0)
                                      a
                                      (f (modulo (* a c) n)
                                         c
                                         (- i 1))))))
(iter 10)

(define fermi1
  '(
    (stan := 18392)
    (while (< 0 k)
           ((w := (r (- n 4) stan))
            (stan := (cdr w))
            (a := (car w))
            (b := (- n 2))
            (c := a)
            (while (< 0 b)
                   ((a := (mod (* a c) n))
                    (b := (- b 1))))
            (if (not (= a 1))
                (k := -10)
                (k := (- k 1)))))
    (if (= k -10)
        (composite := true)
        (composite := false))))
(define fermi11
  '(
    (stan := 1830)
    (while (< 0 k)
           ((w := ((r (- n 4)) stan))
            (stan := (cdr w))
            (a := (car w))
            (b := (- n 2))
            (c := a)
            (while (< 0 b)
                   ((a := (mod (* a c) n))
                    (b := (- b 1))))
            (if (not (= a 1))
                (k := -10)
                (k := (- k 1)))))
    (if (= k -10)
        (composite := true)
        (composite := false))))

(define (probably-prime?1 n k) ; check if a number n is prime using
  ; k iterations of Fermat's primality
  ; test
  (let ([memory (set-mem 'k k
                         (set-mem 'n n empty-mem))])
    (not (get-mem
          'composite
          (eval fermi memory initial-seed)))))

(define (proba i)
  (if ( = i 1)
      0
      (cons (cons i (probably-prime?1 i 10))
            (proba (- i 1)))))
(proba 10)

(define (iter1 i)
  (if (= i 4)
      0
      (cons (eval fermi1 (set-mem 'k 20 (set-mem 'n i empty-mem)) 1)
            (iter1 (- i 1)))))