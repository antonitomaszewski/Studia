#lang racket

(define a (list 1 2 3 4))
(car a)
(cdr a) ;;list jest w istocie zaimplementowana jako n zagniezdzen cons

(define one-through-four (list 1 2 3 4))
one-through-four
(list-ref one-through-four 3)

(define (list-ref01 items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))
(list-ref01 squares 3)
(length squares)

(define (length01 items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(define odds (list 1 3 5 7))
(length odds)

(define (length02 items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ count 1))))
  (length-iter items 0))
(length02 odds)
(append squares odds one-through-four)
(append odds squares)

(define (append01 list01 list02)
  (if (null? list01)
      list02
      (cons (car list01) (append01 (cdr list01) list02))))
(append01 squares odds)

(define (last-pair items)
  (if (null? (cdr items))
      items
      (last-pair (cdr items))))
(last-pair squares)

(define (reverse items)
  (if (null? items)
      null
      (append (reverse (cdr items)) (list (car items)))))
(reverse squares)

(define us-coins (reverse (list 50 25 10 5 1)))
(define uk-coins (reverse (list 10 50 20 10 5 2 1 0.5)))

(define (first01 items)
  (car items))
(define (no-more? coin-values)
  (if (null? coin-values)
      #t
      #f))
(define (first-denomination kinds-of-coins)
  (first kinds-of-coins))
(define (except-first-denomination coin-values)
  (cdr coin-values))
      
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        (( or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(cc 100 (reverse us-coins))

(define (same-parity . liczby)
  (define a (remainder (car liczby) 2))
  (define (helper lista wynik)
    (if (null? lista)
        wynik
        (if (= (remainder (car lista) 2) a)
            (helper (cdr lista) (append wynik (list (car lista))))
            (helper (cdr lista) wynik))))
  (helper liczby null))
(same-parity 1 3 5 7 2 8)
(same-parity 2 4 5 7 9 10)

(define (scale-list items factor)
  (if (null? items)
      null
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))
(scale-list (list 1 2 3 4 5) 10)

(map sqr (list 1 2 3 4))

(define (map01 proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map01 proc (cdr items)))))
(map01 sqr (list 1 2 3 4))

(map01 abs (list -10 2.5 -11.6 17))

(map01 (lambda (x) (* x x))
     (list 1 2 3 4))

(define (scale-list01 items factor)
  (map01 (lambda (x) (* x factor))
         items))

(define (square-list01 items)
  (if (null? items)
      null
      (cons (sqr (car items)) (square-list01 (cdr items)))))
(square-list01 (list 1 2 3 4 5))
(define (square-list02 items)
  (map01 sqr items))
(square-list02 (list 1 2 3 4 5))

(define (square-list03 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (sqr (car things))
                    answer))))
  (iter items null))
(square-list03 (list 1 2 3 4))

(define (square-list04 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (sqr (car things))))))
  (iter items null))

(square-list04 (list 1 2 3 4))

(for-each (lambda (x) (newline) (display x))
  (list 57 321 88))

(define c (cons (list 1 2) (list 3 4)))
(length c)
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
(count-leaves c)
(define c1 (list (cons 1 2) null))
(count-leaves c1)
;;(count-leaves c)
(list 1 (list 2 (list 3 4))) ;;nie ma czegos takiego jak lista jedno elementowa, domyslne zawsze jest tam null, a wartosc trzymana jest tylko na carach
(define d1 '(1 3 '(5 7) 9))
d1
(cdr d1)
(newline)
(cddr d1)
(newline)
(cdddr d1)
(newline)
(caddr d1)
(newline)
(cdaddr d1)
(newline)
(caaddr d1)
(newline)
(cdr (cdaddr d1))
(newline)
(car (cdaddr d1))
(newline)
(cdar (cdaddr d1))
(newline)
(cadar (cdaddr d1))
(define d2 '('(7)))
d2
(caadar d2)

(define d3 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 7)))))))
d3
(cddr (cddddr d3))

(define e1 (list 1 2 3))
(define e2 (list 4 5 6))
(append e1 e2)
(cons e1 e2)
(list e1 e2)

(define (deep-reverse x)
  (cond ((null? x) x)
        ((pair? (car x))
         (append (deep-reverse (cdr x))
                 (list (deep-reverse (car x)))))
        (else
         (append
          (deep-reverse (cdr x))
          (list (car x))))))
(define f1 (list (list 1 2) (list 3 4) (list 5 (list 6 7))))
(deep-reverse f1)

(define (deep-reverse02 x) (reverse (map reverse x)))
(define (deep-reverse01 x)
  (if (list? x)
      (reverse (map deep-reverse01 x))
      x))
(deep-reverse01 f1)

(define (fringe x)