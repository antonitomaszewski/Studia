#lang racket

(define (concat-map f cs)
  (apply append (map f cs)))
(define (convert-to-cnf f)
  (cond [(literal? f) (list f)]
        [(conj? f) (list 'conj (convert-to-cnf (conj-left f))
                           (convert-to-cnf (conj-right f)))]
        [(disj? f)
         (let ((L1 (convert-to-cnf (disj-left f)))
               (L2 (convert-to-cnf (disj-right f))))
           (concat-map (lambda (c)
                  (map (lambda (d) (append c d)) L2))
                  L1))]))
(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'disj (car t))))

(define (var? t)
  (symbol? t))
(define (literal x b)
  (list 'literal b x))
(define (disj-left f)
  (second f))
(define (disj-right f)
  (third f))
(define (conj-left f)
  (second f))
(define (conj-right f)
  (third f))
(define (literal? l)
  (and (list? l)
      (= (length l) 3)
      (eq? (first l) 'literal)
      (boolean? (second l))
      (var? (third l))))

(define (cnf? f)
  (define (pomoc f b)
    (or (literal? f)
      (cond [(and (conj? f) (= b 0)) (and (pomoc (conj-left f) 0)
                                          (pomoc (conj-right f) 0))]
            [(disj? f) (and (pomoc (disj-left f) 1)
                            (pomoc (disj-right f) 1))]
            [else #f])))
  (pomoc f 0))

(define a (list 'conj
                (list 'disj (literal 'x #t) (literal 'y #f))
                (list 'literal #t 'x)))
(cnf? a)
(cnf? (list 'conj a a))
(cnf? (list 'disj a a))
(cnf? (list 'disj (literal 'x #t) (literal 'y #f)))
(literal? (list 'literal #t 'x))
;;(convert-to-cnf (list 'conj a a))

