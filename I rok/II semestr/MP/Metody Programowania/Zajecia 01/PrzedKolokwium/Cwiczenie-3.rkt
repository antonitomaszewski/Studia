#lang racket

;(* (+ 2 2) 5)  -> 20
;(* (+ 2 2) (5)) -> 5 nie jest procedura
;(* (+ (2 2) 5)) -> 2 nie jest procedura
;(* (+ 2 2) 5) -> 20
;(5 * 4) -> 5 nie jest procedura
;(5 * (2 + 2)) -> 5 nie jest procedura
((+ 2 3))
+
(define + (* 2 3))
+
(* 2 +)
(define (five) 5)
(define four 4)
(five)
four
five
(four)