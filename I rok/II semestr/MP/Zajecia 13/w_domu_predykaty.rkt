#lang racket

(require racklog)

(define %knows
  (%rel ()
    [('Odysseus 'TeX)]
    [('Odysseus 'Racket)]
    [('Odysseus 'Prolog)]
    [('Odysseus 'Penelope)]
    [('Penelope 'TeX)]
    [('Penelope 'Prolog)]
    [('Penelope 'Odysseus)]
    [('Telemachus 'TeX)]
    [('Telemachus 'calculus)]))

(define %computer-literate
  (%rel (person)
    [(person)
      (%knows person 'TeX)
      (%knows person 'Racket)]
    [(person)
      (%knows person 'TeX)
      (%knows person 'Prolog)]))

#| person is a computer-literate if he/she knows a tex and racket or text and prolog |#

(%which (what)
    (%knows 'Odysseus what))
(%more)
(%assert! %knows ()
  [('Odysseus 'archery)])
(%assert-after! %knows ()
  [('Telemachus 'archery)])


(define %parent %empty-rel)
 
(%assert! %parent ()
  [('Laertes 'Odysseus)])
 
(%assert! %parent ()
  [('Odysseus 'Telemachus)]
  [('Penelope 'Telemachus)])
(%let (what)
    (%which ()
      (%knows 'Odysseus what)))