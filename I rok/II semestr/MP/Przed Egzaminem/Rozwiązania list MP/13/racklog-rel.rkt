#lang racket

(require racklog)

;; predykat unarny %male reprezentuje zbiór mężczyzn
(define %male
  (%rel ()
        [('adam)]
        [('john)]
        [('joshua)]
        [('mark)]
        [('david)]))

;; predykat unarny %female reprezentuje zbiór kobiet
(define %female
  (%rel ()
        [('eve)]
        [('helen)]
        [('ivonne)]
        [('anna)]
        [('moana)]))

;; predykat binarny %parent reprezentuje relację bycia rodzicem
(define %parent
  (%rel ()
        [('adam 'helen)]
        [('adam 'ivonne)]
        [('adam 'anna)]
        [('eve 'helen)]
        [('eve 'ivonne)]
        [('eve 'anna)]
        [('john 'joshua)]
        [('helen 'joshua)]
        [('ivonne 'david)]
        [('mark 'david)]
        [('john 'ada)]
        [('helen 'ada)]))

;; predykat binarny %sibling reprezentuje relację bycia rodzeństwem
(define %sibling
  (%rel (a b c)
        [(a b)
         (%parent c a)
         (%parent c b)]))

;; predykat binarny %sister reprezentuje relację bycia siostrą
(define %sister
  (%rel (a b)
        [(a b)
         (%sibling a b)
         (%female a)]))

;; predykat binarny %ancestor reprezentuje relację bycia przodkiem
(define %ancestor
  (%rel (a b c)
        [(a b)
         (%parent a b)]
        [(a b)
         (%parent a c)
         (%ancestor c b)]))

;;ćwiczenie 1
(define %grandson
  (%rel (a b c)
        [(a b)
         (%male a)
         (%parent c a)
         (%parent b c)]))

(define %cousin
  (%rel (a b c d)
        [(a b)
         (%ancestor c a)
         (%ancestor d b)
         (%not (%sibling a b))]))

(define %is_mother
  (%rel (a b)
        [(a)
         (%female a)
         (%parent a b)]))

(define %is_father
  (%rel (a b)
        [(a)
         (%male a)
         (%parent a b)]))

(%which () (%grandson 'joshua 'adam))
(%which () (%grandson 'ada 'adam))
(%which () (%cousin 'joshua 'david))
(%which () (%is_mother 'eve))
(%which () (%is_mother 'adam))
(%which () (%is_mother 'ada))
(%which () (%is_father 'eve))
(%which () (%is_father 'adam))
(%which () (%is_father 'david))


;;ćwiczenie 2
(%find-all () (%ancestor 'john 'mark))
(%find-all (person) (%ancestor 'adam person))
(%find-all (person) (%and (%sibling 'ivonne person) (%female person)))
(%find-all (a b) (%and (%cousin a b) (%male b)))
