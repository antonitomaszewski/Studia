#lang racket

;;x

(define z 10)
(define y 3)
(define x 1)

x
;;Przyklad 1
(let ([x 3])
  (+ x y));;y jest globalne, a x tylko w let a pozostale wystapenia x w programie pierdoli!!!
x

;;Przyklad 2
(let ([x 1]
      [y (+ x 2)])
  (+ x y))

;;(let (przypisania) (obliczenia))
;; przypisania wykorzystujemy dopiero w trakcie obliczen,

(let ([x x])
  x)

;;Przyklad 3
(let ([x 1])
  (let ([y (+ x 2)])
    (* x y)))


;;Przyklad 4
((lambda (x y) (* x y z)) 1 2)
;; ((lambda (wprowadza zmnienne, ktore beda obecne tylko w lambdzie) (obliczenia)) (jakie wartosci dajemy tym zmiennym w odpowiedniej kolejnosci))


(let ([x y])
  (* x y z))

;;Przyklad 5
(let ([x 1])
  ((lambda (y z)
    (* x y z)) y z)) 

