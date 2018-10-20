#lang racket

(define (dist x y) (abs (- x y)))
(define (close-enough? x y)
  (< (dist x y) 0.00001))

;; obliczanie (przybliżonego) punktu stałego funkcji f przez iterację, let pozwala uniknąć powtarzania obliczeń
(define (fix-point f x0)
  (let ((x1 (f x0)))
    (if (close-enough? x0 x1)
        x0
        (fix-point f x1))))

;; próba obliczania pierwiastka kwadratowego z x jako punktu stałego funkcji y ↦ x / y zapętla się
;; stosujemy tłumienie z uśrednieniem: procedurę wyższego rzędu zwracającą procedurę jako wynik
(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

(define (sqrt-ad x)
  (fix-point (average-damp (lambda (y) (/ x y))) 1.0))

;; obliczanie pochodnej funkcji z definicji przyjmując dx za "odpowiednio małą" wartość (zamiast "prawdziwej" granicy)
(define (deriv f)
  (let ((dx 0.000001))
    (lambda (x) (/ (- (f (+ x dx)) (f x)) dx))))

;; przekształcenie Newtona: x ↦ x - f(x) / f'(x) pozwala obliczyć miejsce zerowe f jako punkt stały tej transformacji
(define (newton-transform f)
  (lambda (x)
    (- x
       (/ (f x)
          ((deriv f) x)))))

(define (newtons-method f x)
  (fix-point (newton-transform f) x))

;; zastosowania
(define pi (newtons-method sin 3))

(define (sqrt-nm x)
  (newtons-method (lambda (y) (- x (square y))) 1.0))

;; możemy wyabstrahować wzorzec widoczny w definicjach sqrt: znaleźć punkt stały pewnej funkcji *przy użyciu* transformacji
;; argumentem fix-point-of-transform jest procedura przetwarzająca procedury w procedury!
(define (fix-point-of-transform transform f x)
  (fix-point (transform f) x))

ile razy repeated trzeba wywolac
repeated (compose identity f-pierwiastek)
y = x/y(n-1)