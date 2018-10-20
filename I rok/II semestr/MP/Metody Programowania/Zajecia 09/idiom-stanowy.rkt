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

(define (node l r)
  (list 'node l r))

(define (node? n)
  (tagged-tuple? 'node 3 n))

(define (node-left n)
  (second n))

(define (node-right n)
  (third n))

(define (leaf? n)
  (or (symbol? n)
      (number? n)
      (null? n)))

;;

(define (res v s)
  (cons v s))

(define (res-val r)
  (car r))

(define (res-state r)
  (cdr r))

;;

(define (rename t)
  (define (rename-st t i)
    (cond [(leaf? t) (res i (+ i 1))]
          [(node? t)
           (let* ([rl (rename-st (node-left t) i)]
                  [rr (rename-st (node-right t) (res-state rl))])
             (res (node (res-val rl) (res-val rr))
                  (res-state rr)))]))
  (res-val (rename-st t 0)))

;;
;;x,y-obliczenia ze stanem, jak dostana poczatkowy stan to wyprodukuja nam wynik
;;i -to jest stan
(define (st-app f x y)
  (lambda (i)
    (let* ([rx (x i)]
           [ry (y (res-state rx))])
      (res (f (res-val rx) (res-val ry))
           (res-state ry)))))

(define (st-app-list . X)
  (define (pomoc stan x)
    (if (null? x)
        (cons null stan)
        (let ((res ((car x) stan)))
          (let ((dalej (pomoc (res-state res) (cdr x))))
            (cons (cons (res-val res) (car dalej)) (res-state dalej))))))
  (lambda (i)
    (let ((obliczone (pomoc i (cdr X))))
      (cons (apply (car X) (car obliczone))
            (cdr obliczone)))))

(define (st-app-list-iter . X)
  (define (pomoc x vals stan)
    (if (null? x)
        (res (reverse vals) stan)
        (let ((a ((car x) stan)))
          (pomoc (cdr x) (cons (res-val a) vals) (res-state a)))))
  (lambda (i)
    (let ((obliczone (pomoc (cdr X) null i)))
      (cons (apply (car X) (car obliczone))
            (cdr obliczone)))))
(define get-st
  (lambda (i)
    (res i i)))

(define (modify-st f)
  (lambda (i)
    (res null (f i))))

;;

(define (inc n)
  (+ n 1))

(define (rename2 t)
  (define (rename-st t)
    (cond [(leaf? t)
           (st-app-list (lambda (x y) x)
                   get-st
                   (modify-st inc))]
          [(node? t)
           (st-app-list node
                   (rename-st (node-left  t))
                   (rename-st (node-right t)))]))
  (res-val ((rename-st t) 0)))
(define a '(node (node 1 2)
       (node (node 3 4) 5)))
(rename2 a)

(define (rand max)
  (lambda (seed)
    (let ([v (modulo (+ (* 1103515245 seed) 12345) (expt 2 32))])
      (res (modulo v max) v))))

(define (rename-rand t start end)
  (define (rename-st t)
    (cond [(leaf? t)
           (st-app-list (lambda (x) (+ x start))(rand (- end start)))]
          [(node? t)
             (st-app-list node
                           (rename-st (node-left  t))
                           (rename-st (node-right t)))]))
  (res-val ((rename-st t) 2)))
(rename-rand a 10 20)

(foldr
   (lambda (lista stan)
     (res-state (lista stan)))
   0 '(node (node 0 0)
            (node 0 0)))

