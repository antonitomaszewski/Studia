#lang racket


(define (make-signed-message message key-private)
  (cons message (car (RSA-encrypt (intlist->string (list (compress (string->intlist message)))) key-private))))
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

(signature (encrypt-and-sign "Antoni" (make-key 3233 17) (make-key 3233 413)))
(message (encrypt-and-sign "Antoni" (make-key 3233 17) (make-key 3233 413)))

;;(intlist->string (RSA-unconvert-list '(2399) (make-key 3233 413)))
(authenticate-and-decrypt (encrypt-and-sign "Antoni" (make-key 3233 17) (make-key 3233 413))
                          (make-key 3233 413) (make-key 3233 17))