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

; arith and bools

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= mod sqr))))

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
        [(eq? op 'mod) modulo]
        [(eq? op 'sqr) sqr]
        ))

(define (var? t)
  (symbol? t))

(define (eval-arith e m)
  (cond [(var? e) (get-mem e m)]
        [(op? e)
         (apply
          (op->proc (op-op e))
          (map (lambda (x) (eval-arith x m))
               (op-args e)))]
        [(const? e) e]))

;;

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

;;

(define (eval e m)
  (cond [(assign? e)
         (set-mem
          (assign-var e)
          (eval-arith (assign-expr e) m)
          m)]
        [(if? e)
         (if (eval-arith (if-cond e) m)
             (eval (if-then e) m)
             (eval (if-else e) m))]
        [(while? e)
         (if (eval-arith (while-cond e) m)
             (eval e (eval (while-expr e) m))
             m)]
        [(block? e)
         (if (null? e)
             m
             (eval (cdr e) (eval (car e) m)))]))

(define (run e)
  (eval e empty-mem))

;;

(define fact10
  '( (i := 10)
     (r := 1)
     (while (> i 0)
            ( (r := (* i r))
              (i := (- i 1)) ))))

(define (computeFact10)
  (run fact10))

(define (fib n)
  (eval 
   '(( a := 1)
     ( b := 1)
     (while (> i 0)
            ( (c := a)
              (a := (+ a b))
              (b := c)
              (i := (- i 1)))))
   (set-mem 'i n empty-mem)))
(fib 10)
(define (suma-pierwszych n)
  (eval
   '((a := 3)
     (wynik := 2)
     (while (> n 0)
            (b := 3)
            (while (>= a (sqr b))
                   (if (= (mod a b) 0)
                       (b := (+ a 1))
                       (b := (+ b 2))))
            (if (> a b)
                (a := a)
                (wynik := (+ wynik a)))
            (if (> a b)
                (a := a)
                (n := (- n 1)))
            (a := (+ a 2))))
   (set-mem 'n n empty-mem)))
;;(suma-pierwszych 5)

(define (elem-assign l)
  (car l))
#|(define (lista l)
  (define (lista-zmiennych l juz)
    (cond [(null? l) null]
          [(assign? l) (if (member (elem-assign l) juz)
                           (lista-zmiennych (assign-expr l) juz)
                           (lista-zmiennych (assign-expr l) (cons (elem-assign l) juz)))]
          
          [(if? l) (append (lista-zmiennych (if-cond l))
                           (lista-zmiennych (if-then l))
                           (lista-zmiennych (if-else l)))]
          [(while? l) (append (lista-zmiennych (while-cond l))
                              (lista-zmiennych (while-expr l)))]
          [(block? l) (append (list (lista-zmiennych (car l)))
                              (lista-zmiennych (cdr l)))]
          [else null])))|#
#|  (lista-zmiennych '((a := 3)
                     (wynik := 2)
                     (while (> n 0)
                            (b := 3)
                            (while (>= a (sqr b))
                                   (if (= (mod a b) 0)
                                       (b := (+ a 1))
                                       (b := (+ b 2))))
                            (if (> a b)
                                (a := a)
                                (wynik := (+ wynik a)))
                            (if (> a b)
                                (a := a)
                                (n := (- n 1)))
                            (a := (+ a 2)))))|#

;; napoczatku znalezc wszystkie programy do ktorych mozemy isc
;; taka mapa programow




                 



  