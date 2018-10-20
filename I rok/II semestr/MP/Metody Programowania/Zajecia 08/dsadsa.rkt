#lang racket

[(and (list? e)
              (list? (car e))
              (eq? 'lambda (caar e))
              (var? (lambda-vars (car e))))
         (eval-env (lambda-expr (car e)) (add-to-env (lambda-vars (car e))
                                                     (cdr e)
                                                     env))]
[(lambda? e)
         (closure-cons (lambda-vars e) (lambda-expr e) env)]