#lang racket
(define (merge-vars xs ys)
  (cond [(null? xs) ys]
        [(null? ys) xs]
        [(symbol<? (car xs) (car ys))
         (cons (car xs) (merge-vars (cdr xs) ys))]
        [(symbol<? (car ys) (car xs))
         (cons (car ys) (merge-vars xs (cdr ys)))]
        [else (cons (car xs) (merge-vars (cdr xs) (cdr ys)))]))

(define (remove-duplicates-vars xs)
  (cond [(null? xs) xs]
        [(null? (cdr xs)) xs]
        [(symbol=? (car xs) (cadr xs)) (remove-duplicates-vars (cdr xs))]
        [else (cons (car xs) (remove-duplicates-vars (cdr xs)))]))

(define (resolve c1 c2)
  (define (pomoc1 wybieram sprawdzam wynik)
    (cond ((and (null? sprawdzam) (null? wybieram)) wynik)
          ((null? sprawdzam) (append wynik wybieram))        
          ((null? wybieram) wynik)            
          ((member (car wybieram) sprawdzam) (pomoc1 (cdr wybieram) (cdr (member (car wybieram) sprawdzam)) wynik))
          (else
           (pomoc1 (cdr wybieram) sprawdzam (append wynik (list (car wybieram)))))))
                
  (define prawda1 (pomoc1 (second c1) (third c2) null))
  (define falsz1 (pomoc1 (third c1) (second c2) null)) 
  
  (define prawda2 (pomoc1 (second c2) (third c1) null))
  (define falsz2 (pomoc1 (third c2) (second c1) null))
  (define prawda (remove-duplicates-vars (merge-vars prawda1 prawda2)))
  (define falsz  (remove-duplicates-vars (merge-vars falsz1  falsz2 )))
  (if (or (not (= (+ (length prawda1) (length falsz1)) (fourth c1)))
          (not (= (+ (length prawda2) (length falsz2)) (fourth c2))))
        (let ((dlugosc (+ (length prawda) (length falsz))))
          (if (= dlugosc 0)
              #f
            (list 'res-int prawda falsz dlugosc (cons c1 c2))))
      #f))
  

;;(resolve '(res-int (x) (y) 2 'axiom)
        ;; '(res-int () (x) 1 'axiom))
(resolve (list 'res-int
               (list 'x)
               (list 'y)
               2
               'axiom)
         (list 'res-in
               null
               (list 'x)
               1
               'axiom))
(resolve '(res-int (x) (y) 2 'axiom) '(res-int () (x) 1 'axiom))


               

  