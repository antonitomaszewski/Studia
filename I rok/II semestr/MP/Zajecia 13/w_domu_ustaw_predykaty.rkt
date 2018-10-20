#lang racket

(require racklog)


(define %knows
  (%rel ()
        (['Antoni 'Tex])
        (['Basia 'Prolog])
        (['Dominik 'Tex])
        (['Basia 'Racket])
        (['Antoni 'Racket])
        (['Dominik 'Racket])))

;; (%bag-of X G Bag)
(%which (things-known)
        (%let (someone x)
              (%bag-of x (%knows someone x)
                       things-known)))
(%which (things-known)
        (%let (someone x)
              (%set-of x (%knows someone x)
                       things-known)))
(%which (someone things-known)
        (%let (x)
              (%bag-of x
                       (%free-vars (someone)
                                   (%knows someone x))
                       things-known)))

(%which (things-known-Antoni)
        (%let (X)
              (%bag-of X (%knows 'Antoni X) things-known-Antoni)))