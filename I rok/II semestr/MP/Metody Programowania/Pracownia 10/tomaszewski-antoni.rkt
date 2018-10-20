#lang racket

(require "calc.rkt")

(define (def-name p)
  (car p))

(define (def-prods p)
  (cdr p))

(define (rule-name r)
  (car r))

(define (rule-body r)
  (cdr r))

(define (lookup-def g nt)
  (cond [(null? g) (error "unknown non-terminal" g)]
        [(eq? (def-name (car g)) nt) (def-prods (car g))]
        [else (lookup-def (cdr g) nt)]))

(define parse-error 'PARSEERROR)

(define (parse-error? r) (eq? r 'PARSEERROR))

(define (res v r)
  (cons v r))

(define (res-val r)
  (car r))

(define (res-input r)
  (cdr r))

;;

(define (token? e)
  (and (list? e)
       (> (length e) 0)
       (eq? (car e) 'token)))

(define (token-args e)
  (cdr e))

(define (nt? e)
  (symbol? e))

;;

(define (parse g e i)
  (cond [(token? e) (match-token (token-args e) i)]
        [(nt? e) (parse-nt g (lookup-def g e) i)]))

(define (parse-nt g ps i)
  (if (null? ps)
      parse-error
      (let ([r (parse-many g (rule-body (car ps)) i)])
        (if (parse-error? r)
            (parse-nt g (cdr ps) i)
            (res (cons (rule-name (car ps)) (res-val r))
                 (res-input r))))))

(define (parse-many g es i)
  (if (null? es)
      (res null i)
      (let ([r (parse g (car es) i)])
        (if (parse-error? r)
            parse-error
            (let ([rs (parse-many g (cdr es) (res-input r))])
              (if (parse-error? rs)
                  parse-error
                  (res (cons (res-val r) (res-val rs))
                       (res-input rs))))))))

(define (match-token xs i)
  (if (and (not (null? i))
           (member (car i) xs))
      (res (car i) (cdr i))
      parse-error))

;;

(define num-grammar
  '([digit {DIG (token #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)}]
    [numb {MANY digit numb}
          {SINGLE digit}]))

(define (node-name t)
  (car t))

(define (c->int c)
  (- (char->integer c) (char->integer #\0)))

(define (walk-tree-acc t acc)
  (cond [(eq? (node-name t) 'MANY)
         (walk-tree-acc
          (third t)
          (+ (* 10 acc) (c->int (second (second t)))))]
        [(eq? (node-name t) 'SINGLE)
         (+ (* 10 acc) (c->int (second (second t))))]))

(define (walk-tree t)
  (walk-tree-acc t 0))

;;
(define (wywal-nawiasy t)
  (if (eq? (node-name t) 'PARENS)
       (wywal-nawiasy (third t))
       (if (and (list? t) (eq? (node-name t) 'ADD-SINGLE) ;(display "add\n")
                (list? (second t)) (eq? (node-name (second t)) 'MULT-SINGLE)) ;(display "mulst")
                ;(list? (cddr t)) (eq? (node-name (cddr t)) 'PARENS))
           (wywal-nawiasy (second (second t)))
           t)))
                
(define arith-grammar
  (append num-grammar
     '(#|[sub-expr {SUB-MANY mult-expr (token #\-) sub-expr}
                 {SUB-SINGLE mult-expr}]
       [div-expr {DIV-MANY base-expr (token #\/) div-expr}
                 {DIV-SINGLE base-expr}]|#
       [add-expr {ADD-MANY   mult-expr (token #\+ #\-) add-expr}
                 {ADD-SINGLE mult-expr}]
       [mult-expr {MULT-MANY base-expr (token #\* #\/) mult-expr}
                  {MULT-SINGLE base-expr}]
       [base-expr {BASE-NUM numb}
                  {PARENS (token #\() add-expr (token #\))}])))

(define (arith-walk-tree t b- b/ nb- nb/)
  (cond [(eq? (node-name t) 'ADD-SINGLE)
         ;;(display "ADD-SINGLE\n")
         (arith-walk-tree (second t) b- b/ nb- nb/)]
        [(eq? (node-name t) 'MULT-SINGLE)
         ;;(display "MULT-SINGLE\n")
         (arith-walk-tree (second t) b- b/ nb- nb/)]
        #|[(eq? (node-name t) 'SUB-SINGLE)
         (display "SUB-SINGLE\n")
         (arith-walk-tree (second t) b- b/)]
        [(eq? (node-name t) 'DIV-SINGLE)
         (arith-walk-tree (second t) b- b/)]|#
        [(eq? (node-name t) 'ADD-MANY)
         (if (eq? (third t) #\+)
             (if (or (= b- 0) (= nb- 0))
                 (binop-cons
                  '+
                  (arith-walk-tree (second t) b- b/ nb- nb/)
                  (arith-walk-tree (fourth t) b- b/ nb- nb/))
                 (binop-cons
                  '-
                  (arith-walk-tree (second t) b- b/ nb- nb/)
                  (arith-walk-tree (fourth t) b- b/ nb- nb/)))
             (if (= b- 0)
                 (binop-cons
                  '-
                  (arith-walk-tree (second t) 1 b/ 1 nb/)
                  (arith-walk-tree (fourth t) 1 b/ 1 nb/))
                 (binop-cons
                  '+
                  (arith-walk-tree (second t) b- b/ nb- nb/)
                  (arith-walk-tree (fourth t) b- b/ nb- nb/))))]
        [(eq? (node-name t) 'MULT-MANY)
         (if (eq? (third t) #\*)
             (if (or (= b/ 0) nb/)
                 (binop-cons
                  '*
                  (arith-walk-tree (second t) b- b/ nb- nb/)
                  (arith-walk-tree (fourth t) b- b/ nb- nb/))
                 (binop-cons
                  '/
                  (arith-walk-tree (second t) b- b/ nb- nb/)
                  (arith-walk-tree (fourth t) b- b/ nb- nb/)))
             (if (= b/ 0)
                 (binop-cons
                  '/
                  (arith-walk-tree (second t) b- 1 nb- 1)
                  (arith-walk-tree (fourth t) b- 1 nb- 1))
                 (binop-cons
                  '*
                  (arith-walk-tree (second t) b- b/ nb- nb/)
                  (arith-walk-tree (fourth t) b- b/ nb- nb/))))]
        [(eq? (node-name t) 'BASE-NUM)
         (walk-tree (second t))]
        [(eq? (node-name t) 'PARENS)
         (arith-walk-tree (wywal-nawiasy t) (modulo (+ b- nb-) 2) (modulo (+ b/ nb/) 2) nb- nb/)
         #|(if (= nb- 0)
             (if (= nb/ 0)
                 (arith-walk-tree (third t) b- b/ nb- nb/)
                 (arith-walk-tree (third t) b- (modulo (+ b/ 1) 2) nb- nb/))
             (if (= nb/ 0)
                 (arith-walk-tree (third t) (modulo (+ b- 1) 2) b/ nb- nb/)
                 (arith-walk-tree (third t) (modulo (+ b- 1) 2) (modulo (+ b/ 1) 2) nb- nb/)))|#
]))
         ;;(arith-walk-tree (third t) (modulo (+ b- 1) 2) (modulo (+ b/ 1) 2))]))

(define (calc s)
 (eval
  (arith-walk-tree
   (car
    (parse
       arith-grammar
       'add-expr
       (string->list s)))
   0 0 0 0)))

;;(calc "3*2")

#|
(define (repair-expr e)
  (define (helper e b- b/)
    (if (null? e)
        null
        (if (member (car e) '(#\- #\+ #\* #\/))
            (cond [(eq? (car e) '#\-) (if (= b- 0)
                                          (cons '#\- (list(helper (cdr e) 1 b/)))
                                          (cons '#\+ (
|#
(calc "2+1") ;;3
(calc "(2+1)-1-1") ;1
(calc "(2+1)-(1-1)") ;;3
(calc "(2+1)-(2/1/2)") ;;2
(calc "2/1") ;;2
(calc "2/1/2") ;;1
(calc "(2/1/2)") ;;1
(calc "(2-1-2)") ;;-1
(calc "1/(2/1/2)") ;;1
(calc "1/2/1/2") ;;1/4
(calc "(1/2)/(1/2)") ;;1
;;(string->list "((1))")
(calc "1-(1-2)") ;;2
(calc "1-((1-2))")
(calc "1-(((1-2)))")
(calc "1-(((((((1-2+(1-1))))))))") ;;2
(calc "1-(((((((1-2+(1-2))))))))") ;;3
(calc "(1-(2-3))-(4+5)") ;;-7
(calc "(1-(2-3))-(4-5)") ;;3
(calc "(1-(2-3))-((4-5-2))") ;;5
(calc "(1-2-3-4-5)") ;;-13
(calc "2+1*3-1-1/3/3") ;;3.(8)
(calc "2-1-1-1-1-1") ;;-3