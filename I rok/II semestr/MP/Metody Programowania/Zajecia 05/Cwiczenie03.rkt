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
  (define (iter1 f1)
    (if (var? f1)
        (list f1)
        (if (neg? f1)
            (iter1 (neg-subf f1))
            (append (iter1 (second f1)) (iter1 (third f1))))))
  (define wynik1 (iter1 f))
  (czyszczenie wynik1 null))

(define (gen-vals xs)
  (if (null? xs)
      (list null)
      (let*
          ((vdd (gen-vals (cdr xs)))
           (x (car xs))
           (vst (map (lambda (vs) (cons (list x true) vs)) vss))
           (vsf (map (lambda (vs) (cons (list x false) vs)) vss)))
        (append vst vsf))))

(define (eval-var var valueing)
  (let ((res (assoc valueing var)))
    (if res
        (cadr res)
        (error "dsdsa"))))

(define (eval-formula formula valueing)
  (cond [(disj? formula) (or (eval-formula (disj-left formula) valueing)
                             (eval-formula (disj-right formula) valueing))]
        [(var? formula) (eval-var (var formula) valueing)]))

;;(define
;;((gen-vals (list 'x 'y)) (list 'a 'b))

(define (falsifiable-eval? f)
  (define zmienne (free-vars f))
  (define wartosciowania (gen-vals zmienne))
  (define (iter formula wartosciowania)
    (if (null? wartosciowania)
        #f
        (if 