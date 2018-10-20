#lang racket

(define (nnf? f)
  (define (iter form byl-juz)
    (if byl-juz
        (if (or (disj? form) (conj? form))
            #f
            (if (or (var? form) (and (neg? form) (var? (neg-subf form))))
                #t
                #f))
        (if (disj? form)
            (and (iter (disj-left form) #f) (iter (disj-right form) #f))
            (if (conj? form)
                (and (iter (conj-left form) #t) (iter (conj-right form) #t))
                (iter (neg-subf form) #t)))))
  (iter f #f))

(define (literal? x)
  (and (list? x)
       (eq? (car x) 'literal)
       (or (var? x) (and (neg? x) (var? (neg-subf x))))))
(define (literal n x)
  (if (eq? n 'neg)
      (list 'literal 'neg x)
      (list 'literal x)))

(define (nnf?01 f)
  (or (var? f)
      (and (neg? f)
           (var? (neg-subf f)))
      (and (conj? f)
           (nnf?01 (conj-left f))
           (nnf?01 (conj-right f)))
      (and (disj? f)
           (nnf?01 (disj-left f))
           (nnf?01 (disj-right f)))))

