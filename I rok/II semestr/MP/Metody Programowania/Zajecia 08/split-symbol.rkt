#lang racket

(define (split-symbol s)
  (define (char->symbol a)
    (string->symbol (list->string (list a))))
  (map char->symbol (string->list (symbol->string s))))