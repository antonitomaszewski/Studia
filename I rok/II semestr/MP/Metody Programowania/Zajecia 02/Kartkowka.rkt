#lang racket

(lambda (x y z)
  (+ x y)) ;; wolne: + ,zwiazane: x y z

(let ([x 3])
  (let ([y x])
    (f x y x)));; wolne: f ,zwiazanie: x y

(let ([x y]
      [y x])
  (* 2 x y))  ;;wolne: y x *, zwiazane: x y

(let ([x 42]
      [y ( + x 3)])
  (lambda (f x)
    (f x y))) ;;wolne: + x, zwiazane: x y f x 

