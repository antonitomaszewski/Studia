#lang racket

;x -> wolne
(let ([x 3])
  (+ x y))  ;y-> wolne x zwiazanie z 3
(let ([x 1]
  [y (+ x 2)])
  (+ x y)); x -> zwiazanie z 1, y->zwiazane, x w wyrazeniu wolne, nastepne to te z leta
(let ([x 1])  ;wprowadzenie x
  (let ([y (+ x 2)])  ;;wprowadzenie y - zwiazanie z juz zwiazanym x
    (* x y)))  ; x zwiazane y->
(lambda (x y)
  (* x y z))  ; x,y zwiazane, z wolne
(let ([x 1]) ;;wprowadzenie x
  (lambda (y z) ;wprowadzenie y i z
    (* x y z)))  ;wszystkie są związane
jak mamy wiele zagniezdzonych lambd
to ta która jest najbardziej na wierzchu dostanie argument, który jest
najbardziej schowany 