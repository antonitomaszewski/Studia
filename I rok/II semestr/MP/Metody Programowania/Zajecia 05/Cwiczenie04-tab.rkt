#lang racket

(define (var? t)
  (symbol? t))   ;;symbol to 'zmienna

(define (neg? t)
  (and (list? t)
       (= 2 (length t))
       (eq? 'neg (car t))))

(define (conj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'conj (car t))))

(define (disj? t)
  (and (list? t)
       (= 3 (length t))
       (eq? 'dist (car t))))

(define (prop? f)
  (or (var? f)
      (and (neg? f)
           (prop? (neg-subf f)))
      (and (conj? f)
           (prop? (conj-left f))
           (prop? (conj-right f)))
      (and (disj? f)
           (prop? (disj-left f))
           (prop? (disj-right f)))))

(define (var x) x)
(define (neg x)
  (list 'neg (var x)))
(define (conj x y)
  (list 'conj (var x) (var y)))
(define (disj x y)
  (list 'disj (var x) (var y)))

(define (neg-subf f)
  (second f))
(define (disj-left f)
  (second f))
(define (disj-right f)
  (third f))
(define (conj-left f)
  (second f))
(define (conj-right f)
  (third f))

(define (literal neg var)
  (list 'literal neg var))
(define (literal-neg var)
  (second var))
(define (literal-var var)
  (third var))
(define (literal? l)
  (and (eq? (first l) 'literal)
       (boolean? (second l))
       (var? (third l))))
(define (nnf? f)
  (cond [(literal? f) #t]
        [(disj? f) (and (nnf? (disj-left f))
                        (nnf? (disj-right f)))]
        [(conj? f) (and (nnf? (conj-left f))
                        (nnf? (conj-right f)))]
        [else #f]))
(define (eval-literal l valuing)
  (let ((res (eval-var (literal-var l) valuing)))
    (if (literal-neg l)
        (neg res)
        res)))

(define (podwojna-negacja f)
  (cond
    ((var? f) (neg f))
    ((neg? f) (convert-to-nnf (neg-subf f)))
    ((disj? f) (conj (podwojna-negacja (convert-to-nnf (disj-left f))) (podwojna-negacja (convert-to-nnf (disj-right f)))))
    ((conj? f) (disj (podwojna-negacja (convert-to-nnf (conj-left f))) (podwojna-negacja (convert-to-nnf (conj-right f)))))))   
    
(define (convert-to-nnf f)
  (cond ((disj? f)
         (disj (convert-to-nnf (disj-left f))
            (convert-to-nnf (disj-right f))))
      ((conj? f)
       (conj? (convert-to-nnf (conj-left f))
            (convert-to-nnf (conj-right f))))
      ((var? f) f)
      ((neg? f) (podwojna-negacja (neg-subf f)))))

  