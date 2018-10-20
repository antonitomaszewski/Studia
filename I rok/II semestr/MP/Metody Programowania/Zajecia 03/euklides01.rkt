#lang racket

(define (nwd a b)
  (if (= b 0)
      a
      (nwd b (modulo a b))))
(nwd 2 9)



(define (// a b)
  (/ (- a (modulo a b)) b))
(// 13 3)

(define (solve-ax+by=1 a b)
  (define (// a b)
  (/ (- a (modulo a b)) b))
  (define (helper para)
    (let ((a (car para))
          (b (cdr para)))
      (if (not (= b 0))
          (let ((pom (helper (cons b (modulo a b)))))
            (cons (cdr p) (- (car p)  (* (/ (- (// a b) b) b)
                  (cdr p)

                  
    
    
    
        