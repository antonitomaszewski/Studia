#lang racket

(define (convert-to-nnf f)
  (cond [(var? f) (literal true f)]
        [(disj? f) (disj (convert-to-nnf (disj-left f)) (convert-to-nnf (disj-right f)))]
        [(conj? f) (conj (convert-to-nnf (conj-left f)) (convert-to-nnf (conj-right f)))]
        [(neg? f) (nnf-negate (neg-subf f))]))

(define (nnf-negate f)
  (cond [(var? f) (literal false f)]
        [(disj? f) (conj (nnf-negate (disj-left f)) (nnf-negate (disj-right f)))]
        [(neg? f) (convert-to-nnf (neg-subf f))]))

;;mozna ja napisac z k - licznikiem ile bylo falszy

(define (convert-to-cnf f)
  (cond [(literal? f) (list '(f))]
        [(conj? f) (append (convert-to-cnf (conj-left f))
                           (convert-to-cnf (conj-right f)))]
        [(disj? f)
         (let ((L1 (convert-to-cnf (disj-left f)))
               (L2 (convert-to-cnf (disj-right f))))
           (concat-map (lambda (c)
                  (map (lambda (d) (append c d)) L2)
                  L1)))]))
(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'dist (car t))))

(define (cnf-left f)
  (second f))
(define (cnf-right f)
  (third f))
(define (literal? l)
  (and (eq? (first l) 'literal)
       (boolean? (second l))
       (var? (third l))))

(define (cnf? f)
  (define (pomoc f b)
    (or (literal? f)
      (cond [(and (conj? f) (= b 0)) (and (pomoc (cnf-left f) b)
                                          (pomoc (cnf-right f) b))]
            [(disj? f) (and (pomoc (cnf-left f) 1)
                                          (pomoc (cnf-right f) 1))]
            [else #f])))
  (pomoc f 0))

