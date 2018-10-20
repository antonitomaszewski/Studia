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

(define formula (neg 'y))
(prop? formula)
(neg? formula)

(define (free-vars f)
  (define (czy-nie-jest w L)
    (if (null? L)
        #t
        (if (eq? (car L) w)
            #f
            (czy-nie-jest w (cdr L)))))
  (define (czyszczenie L W)
    (if (null? L)
        L
        (if (czy-nie-jest (car L) (cdr L))
            (let ((W1 (append W (list (car L)) (czyszczenie (cdr L) W))))
              W1)
            (let ((W1 (append W (czyszczenie (cdr L) W))))
              W1))))
  (define (iter L f1)
    (if (var? f1)
        (if (czy-nie-jest f1 L)
            (list f1)
            null)
        (if (neg? f1)
            (append L (iter L (neg-subf f1)))
            (append L (append (iter L (second f1)) (iter L (third f1)))))))
  (define (iter1 f1)
    (if (var? f1)
        (list f1)
        (if (neg? f1)
            (iter1 (neg-subf f1))
            (append (iter1 (second f1)) (iter1 (third f1))))))
  (define wynik (iter null f))
  (define wynik1 (iter1 f))
  ;;(list wynik (czyszczenie wynik null) wynik1 (czyszczenie wynik1 null))
  (czyszczenie wynik1 null))
  ;;wynik1
  ;;wynik
  ;;(iter null f)
  ;;wynik
  ;;(czyszczenie wynik null))

(define formula2 (disj 'z (disj (conj 'a 'b) (disj (neg 'x) (disj 'y 'y)))))
;;(free-vars (car formula2))
;;formula2
(free-vars formula2)

            





    






