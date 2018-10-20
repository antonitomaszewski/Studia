#lang typed/racket

(: prefixes (All (A) (-> (Listof A) (Listof (Listof A)))))
(define (prefixes Xs)
  (: helper (All (A n) (-> (Listof A) Integer (Listof (Listof A)))))
  (define (helper Xs n)
    (if (= n 0)
        null
        (cons (first-n Xs n) (helper Xs (- n 1)))))
  (helper Xs (length Xs)))

(: first-n (All (A n) (-> (Listof A) Integer (Listof A))))
(define (first-n Xs n)
  (if (= n 0)
      null
      (cons (car Xs) (first-n (cdr Xs) (- n 1)))))

(: prefixes-tab (All (A) (-> (Listof A) (Listof (Listof A)))))
(define (prefixes-tab xs)
  (if (null? xs) (list null)
      (let ([prefs (prefixes (cdr xs))])
        (cons null (map (lambda (ys) (cons (car xs) ys)) prefs)))))