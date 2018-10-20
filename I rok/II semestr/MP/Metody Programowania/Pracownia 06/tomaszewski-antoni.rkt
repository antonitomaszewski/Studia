#lang racket

(define (const? t)
  (number? t))

(define (binop? t)
  (and (list? t)
       (= (length t) 3)
       (member (car t) '(+ - * /))))

(define (binop-op e)
  (car e))

(define (binop-left e)
  (cadr e))

(define (binop-right e)
  (caddr e))

(define (binop-cons op l r)
  (list op l r))

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

(define (hole? t)
  (eq? t 'hole))

(define (arith/let/holes? t)
  (or (hole? t)
      (const? t)
      (and (binop? t)
           (arith/let/holes? (binop-left  t))
           (arith/let/holes? (binop-right t)))
      (and (let? t)
           (arith/let/holes? (let-expr t))
           (arith/let/holes? (let-def-expr (let-def t))))
      (var? t)))

(define (num-of-holes t)
  (cond [(hole? t) 1]
        [(const? t) 0]
        [(binop? t)
         (+ (num-of-holes (binop-left  t))
            (num-of-holes (binop-right t)))]
        [(let? t)
         (+ (num-of-holes (let-expr t))
            (num-of-holes (let-def-expr (let-def t))))]
        [(var? t) 0]))

(define (arith/let/hole-expr? t)
  (and (arith/let/holes? t)
       (= (num-of-holes t) 1)))

(define (hole-context e)
  (define (pomoc e wynik)
    (cond [(hole? e) wynik]
          [(let? e) (cond [(hole? (let-def-expr (let-def e))) wynik]
                          [(arith/let/hole-expr? (let-def-expr (let-def e))) (pomoc (let-def-expr (let-def e)) wynik)]
                          [else (pomoc (let-expr e) (cons (let-def-var (let-def e)) wynik))])]
          [(binop? e) (if (arith/let/hole-expr? (binop-left e))
                          (pomoc (binop-left e) wynik)
                          (pomoc (binop-right e) wynik))]
          ;;[else wynik]
          ))
  (define a (pomoc e null))
  (if (list? a)
      (if (list? (remove-duplicates a))
          (remove-duplicates a)
          a)
      a))


(define (test)
  (define (dobry-wynik e proponowany)
     (equal? (sort (hole-context e) symbol<?) proponowany))
  (define a '(let (x (let (y 3) (+ y hole))) 5)) ;;wynik=='(y)
  (define a1 '(let (a 1) (let (b 2) (let (c (let (c1 4) 5)) (+ a hole))))) ;;wynik=='(a b c)
  (define a2 '(let (d (let (a 1) (let (b 2) (let (c (let (c1 4) 5)) (+ a hole))))) 5)) ;;wynik=='(a b c)
  (define a3 '(let (d (let (a 1) (let (b 2) (let (c (let (c1 4) 5)) (+ a b))))) hole)) ;;wynik=='(d)
  (define a4 '(let (a 1) hole)) ;;wynik=='(a)
  (define a5 '(let (a5 10) (+ (+ hole a5) a5))) ;;wynik=='(a5)
  (define a6 '(let (a6 10) (let (a7 11) (let (a8 12) hole)))) ;;wynik=='(a6 a7 a8)
  (list (dobry-wynik a '(y))
        (dobry-wynik a '(b))
        (dobry-wynik a1 '(a b c))
        (dobry-wynik a2 '(a b c))
        (dobry-wynik a3 '(d))
        (dobry-wynik a4 '(a))
        (dobry-wynik a5 '(a5))
        (dobry-wynik a6 '(a6 a7 a8))
       )
  )
(test)
