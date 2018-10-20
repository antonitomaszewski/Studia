#lang racket


(define (skrzynka tekst klucz))
  
(define (protokol tekst key-in key-out)
  )

(define (make-signed-message message key-private)
  (cons message (car (RSA-encrypt (intlist->string (list (compress message))) key-private))))
(define (signature para)
  (cdr para))
(define (message para)
  (car para))

(define (encrypt-and-sign message key-public key-private)
  (cons (RSA-encrypt message key-public) (signature (make-signed-message message key-private))))

(define (authenticate-and-decrypt encrypted-message key-private key-public)
  (if (= (signature encrypted-message) (car (RSA-encrypt (signature encrypted-message) key-public)))
      (RSA-decrypt message key-private)
      (error "Oszust!")))

