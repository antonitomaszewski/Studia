#lang racket

(require racklog)

;; predykat unarny %male reprezentuje zbiór mężczyzn
(define %male
  (%rel ()
        [('adam)]
        [('john)]
        [('joshua)]
        [('mark)]
        [('david)]))

;; predykat unarny %female reprezentuje zbiór kobiet
(define %female
  (%rel ()
        [('eve)]
        [('helen)]
        [('ivonne)]
        [('anna)]))

;; predykat binarny %parent reprezentuje relację bycia rodzicem
(define %parent
  (%rel ()
        [('A 'B)]
        [('C 'A)]
        [('adam 'helen)]
        [('adam 'ivonne)]
        [('adam 'anna)]
        [('eve 'helen)]
        [('eve 'ivonne)]
        [('eve 'anna)]
        [('john 'joshua)]
        [('helen 'joshua)]
        [('ivonne 'david)]
        [('mark 'david)]))

;; predykat binarny %sibling reprezentuje relację bycia rodzeństwem
(define %sibling
  (%rel (a b c)
        [(a b)
         (%parent c a)
         (%parent c b)]))

;; predykat binarny %sister reprezentuje relację bycia siostrą
(define %sister
  (%rel (a b)
        [(a b)
         (%sibling a b)
         (%female a)]))

;; predykat binarny %ancestor reprezentuje relację bycia przodkiem
(define %ancestor
  (%rel (a b c)
        [(a b)
         (%parent a b)]
        [(a b)
         (%parent a c)
         (%ancestor c b)]))

;; Cwiczenie 1.
(define %grandson
  (%rel (a b c)
        [(a b)
         (%male a)
         (%parent c a)
         (%parent b c)]))
(define %cousin
  (%rel (a b c d)
        [(a b)
         (%parent c a)
         (%parent d b)
         (%sibling b d)]))
(define %is_mother
  (%rel (a b)
        [(a)
         (%parent a b)
         (%female a)]))
(define %is_father
  (%rel (a b)
        [(a)
         (%parent a b)
         (%male a)]))

;; Cwiczenie 2.
(%which () (%ancestor 'Mark 'John))

(%find-all (x) (%ancestor 'adam x))
(%find-all (x) (%sister x 'ivonne))

(%let (y)
      (%find-all (x) (%cousin x y)))


;; Cwiczenie 3.
(define %select
  (%rel (x xs y ys)
        [(x (cons x xs) xs)]
        [(y (cons x xs) (cons x ys))
         (%select y xs ys)]))

(%which (x y) (%append x x y))
(%more)
(%which (x) (%and (%member x '(1 2 3 4))
                  (%not (%member x '(1 2 4)))))
(%which (x) (%select x '(1 2 3 4) '(1 2 4)))

(%which (x) (%append '(1 2 3) x '(1 2 3 4 5)))
(%which (x) (%= (append '(1 2 3) x) '(1 2 3 4 5)))
(%which (x) (%append x '(1 2) '(0 1 2)))
(%which (x) (%= (append (list x) '(1 2)) '(0 1 2)))
;; Cwiczenie 4.
(%find-all (x y) (%append x y '(1 2 3)))

;; Cwiczenie 5.
(display "\nCwiczenie 5.\n")
(%which (x) (%= (list 'a x) (list 'a 'b)))

(%which (x y) (%= (list 'f (list 'g x) x) (list 'f y 'a)))
;;zapetla sie (%which (x) (%= x (list 'f x)))
(use-occurs-check? #t)
(%let (x) (%which () (%= x (list 'f x))))
(%which (x y) (%= x (list 'g y)))
(%which (x) (%= (list 'a) (list 'a x)))
(%which (x) (%= (list 'a) (cons 'a x)))
(%which (x y z) (%= (list 'a (list x x) (list y y)) (list x y z)))


;; Cwiczenie 6.

(define %sublist
  (%rel (x xs ys)
        [(null null)]
        [((cons x xs) (cons x ys))
         (%sublist xs ys)]
        [(xs (cons x ys))
         (%sublist xs ys)]
        ))
(%which () (%sublist '(1 2 3) '(1 2 3)))

(%which () (%sublist '() '()))

(%which () (%sublist '(1 2) '(1 0 2)))
(%which () (%sublist '(1 0 2) '(1 2)))

(%which (x) (%sublist x '(1 2)))
(%which (x) (%sublist '(1 2) x))
(%find-all (x) (%sublist x '(1 2)))

(define %perm
  (%rel (x xs-left xs-right ys-left ys-right)
        [((append xs-left (cons x xs-right))
          (append ys-left (cons x ys-right)))
         (%perm (append xs-left xs-right)
                (append ys-left ys-right))]))


(define %perm-tab
  (%rel (x xs ys zs)
        [(null null)]
        [((cons x xs) ys)
         (%select x ys zs)
         (%perm-tab xs zs)]))
(%find-all (x) (%perm-tab x '(1 2 3)))

(define %struct
  (%rel (x xs ys)
        [(null null)]
        [((cons x xs) (cons x ys)) (%struct xs ys)]))

(define (list->num X)
  (define (helper X)
    (if (null? X)
        (cons 0 1)
        (let ([dalej (helper (cdr X))])
          (cons (+ (car dalej) (* (car X) (cdr dalej)))
                (* (cdr dalej) 10)))))
  (car (helper X)))

#|
(define %length
  (%rel (x len)
        [(
|#
;; which nie potrzebuje anda, find-all potrzebuje
(%let (xs)
      (%which (d e m n o r s y)
              (%and (%sublist xs '(0 1 2 3 4 5 6 7 8 9))
                    (%length xs 8)
                    (%perm (list d e m n o r s y) xs)
                    (%=/= s 0)
                    (%=/= m 0)
                    (%is a (+ (list->num (list s e n d))
                              (list->num (list m o r e))))
                    (%= b (list->num (list m o n e y))))))





