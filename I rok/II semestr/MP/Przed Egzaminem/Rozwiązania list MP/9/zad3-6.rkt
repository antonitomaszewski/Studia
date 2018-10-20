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

(define (inc i) (+ i 1))
(define (dec i) (- i 1))

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
       (member (car t) '(+ - * / = > >= < <= % ++ --))))

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
        [(eq? op '%) modulo]
        [(eq? op '++) inc]
        [(eq? op '--) dec]))

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

(define (while cond expr)
  (list 'while cond expr))

(define (while-cond t)
  (second t))

(define (while-expr t)
  (third t))

(define (block? t)
  (list? t))

(define (block . args) args)

;;for

(define (for? e)
  (tagged-tuple? 'for 5 e))

(define (for-assign e)
  (second e))

(define (for-cond e)
  (third e))

(define (for-app e)
  (fourth e))

(define (for-block e)
  (fifth e))

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
        [(for? e) (eval (block (for-assign e) (while (for-cond e) (block (for-block e) (for-app e)))) m)]
        [(block? e)
         (if (null? e)
             m
             (eval (cdr e) (eval (car e) m)))]
        ))

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

;;ZADANIE 3


(define fib
  '( (i := 4)
     (f0 := 0)
     (f1 := 1)
     (while (> i 1)
        ( (result := (+ f0 f1))
          (f0 := f1)
          (f1 := result)
          (i := (- i 1))))))
"zadanie 3"
"fib"
(run fib)

(define sum
  '( (result := 2)
     (i := 5)
     (n := 2)
     (while (> i 1)
            ( (d := 2)
              (while (<= (* d d) n)
                     ( (if (= (% n d) 0)
                           (d := n)
                           (d := (+ 1 d)))))
                  (if (= d n)
                  (n := (++ n))
                  ( (result := (+ result n))
                    (i := (- i 1))
                    (n := (+ 1 n))))))))
              
"sum"
(run sum)

;;ZADANIE 4

(define (list-var p)
  (define (vars mem acc)
    (if (null? mem)
        acc
        (vars (cdr mem) (cons (caar mem) acc))))
  (vars (run p) null))

"zadanie 4"
(list-var sum)

;;ZADANIE 5

(define test
  '( (sum := 0)
     (for (i := 0) (<= i 5) (i := (++ i)) (sum := (+ sum i)))))

(run test)