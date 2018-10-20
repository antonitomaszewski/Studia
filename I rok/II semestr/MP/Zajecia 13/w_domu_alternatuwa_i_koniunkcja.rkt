#lang racket

(require racklog)

(define wypisz_wszystkie
  (lambda () (let ([wynik (%more)])
               (if wynik
                   (cons (car wynik)
                         (wypisz_wszystkie))
                   #f))))

(%which (x)
        (%and (%member x '(1 2 3))
              (%< x 3)))
(%more)
(%more)

(%which (x)
        (%or (%member x '(1 2 3))
             (%member x '(3 4 5))))
(wypisz_wszystkie)

;; W końcu zapisane normalnie
(define %knows
  (%rel ()
        (['Antoni 'Racket])
        (['Basia 'Prolog])
        (['Dominik 'Tex])
        (['Antoni 'Tex])
        (['Basia 'Racket])
        (['Dominik 'Racket])))
        
    
(define %computer-literate
  (lambda (person)
    (%and (%knows person
            'TeX)
      (%or (%knows person
             'Racket)
        (%knows person
          'Prolog)))))

(%which (X)
          (%and (%/== 1 2)
                (%var X)))
(%which (X)
          (%and (%/== 1 2)
                (%nonvar X)))
