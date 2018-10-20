#lang racket
(define prawda (remove-duplicates-vars (merge-vars prawda1 prawda2)))
  (define falsz  (remove-duplicates-vars (merge-vars falsz1  falsz2 )))
  (if (or (not (= (+ (length prawda1) (length falsz1)) (fourth c1)))
          (not (= (+ (length prawda2) (length falsz2)) (fourth c2))))
        (let ((dlugosc (+ (length prawda) (length falsz))))
          (if (= dlugosc 0)
              #f
            (list 'res-int prawda falsz dlugosc (cons c1 c2))))
      #f))

(define (resolve c1 c2)
  (define (pomoc1 wybieram sprawdzam wynik)
    (if (or (null? sprawdzam) (null? wybieram))
        wynik
        (if (member (car wybieram) sprawdzam)
            (pomoc1 (cdr wybieram) (cdr (member (car wybieram) sprawdzam)) wynik)
            (pomoc1 (cdr wybieram) sprawdzam (append wynik (list (car wybieram)))))))
  (define (laczenie pierwszy drugi wynik)
    (if (null? pierwszy)
        (append wynik drugi)
        (if (null? drugi)
            (append wynik pierwszy)
            (if (eq? (car pierwszy)
                     (car drugi))
                (laczenie (cdr pierwszy) (cdr drugi) (append wynik (list (car pierwszy))))
                (if (symbol<? (car pierwszy) (car drugi))
                    (laczenie (cdr pierwszy)
                              drugi
                              (append wynik (list (car pierwszy))))
                    (laczenie pierwszy (cdr drugi) (append wynik (list (car pierwszy)))))))))
                
  (define prawda1 (pomoc1 (second c1) (third c2) null))
  (define falsz1 (pomoc1 (third c1) (second c2) null))
  
  (define prawda2 (pomoc1 (second c2) (third c1) null))
  (define falsz2 (pomoc1 (third c2) (second c1) null))
  (if (or (not (= (+ (length prawda1) (length falsz1)) (fourth c1)))
          (not (= (+ (length prawda2) (length falsz2)) (fourth c2))))
      (let ((a (laczenie prawda1 prawda2 null))
            (b (laczenie falsz1 falsz2 null)))
        (let ((dlugosc (+ (length a) (length b))))
          (if (= dlugosc 0)
              #f
            (list 'res-int a b dlugosc (cons c1 c2)))))
      #f))wwwwww