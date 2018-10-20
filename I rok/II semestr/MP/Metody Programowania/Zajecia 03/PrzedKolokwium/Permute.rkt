#lang racket
(define (seq start end) 
  (if (= start end) 
      (list end)    ; if start and end are the same number, we are done
      (cons start (seq (+ start 1) end)) 
      )
  )
(define (insert cdrList n carItem)
  (if (= 0 n)
      (cons carItem cdrList) ; if n is 0, prepend carItem to cdrList
      (cons (car cdrList)  
            (insert (cdr cdrList) (- n 1) carItem))))
(define (permute mylist)
  (cond 
    [(null? mylist) '(())]
    [else 
     (define (genCombinationsFor plist)
       (define (combineAt n) (insert plist n (car mylist)))
       (map combineAt (seq 0 (length plist))))
     (apply append (map genCombinationsFor (permute (cdr mylist))))]))
(seq 0 10)
(insert '(1 2 3) 3 '(5 6))