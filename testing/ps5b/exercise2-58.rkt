#lang racket

;; Name: Roy Van Liew
;; Section: 91.301.201 - Organization of Programming Languages

;; Exercise 2.58 on pp. 151.
;; Converting the differentiator to infix. Do subproblem (a) only.

;; You will need to change the following procedures:
;; make-sum
;; sum?
;; addend
;; make-product
;; product
;; multiplier
;; make-exponentiation
;; base
;; exponent

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

;;; SUM EXPRESSIONS

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2) ; If a1 is zero, just return a2 (this is 0 + a2)
	((=number? a2 0) a1) ; If a2 is zero, just return a1 (this is a1 + 0)
	((and (number? a1) (number? a2)) (+ a1 a2)) ; Just do addition if both are numbers
	(else (list a1 '+ a2)))) ; Otherwise, return a symbolic addition expression

; Check that it's a pair and if the plus is in the middle
(define (sum? x)
  (and (pair? x) (eq? (car (cdr x)) '+)))

; First add term is at the start since plus is in the middle for infix
(define (addend s) (car s))

(define (augend s) (caddr s))


;;; MULTIPLICATION EXPRESSIONS

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0) ; Anything multiplied by 0 is 0
	((=number? m1 1) m2) ; 1 * m2 = m2
	((=number? m2 1) m1) ; m1 * 1 = m1
	((and (number? m1) (number? m2)) (* m1 m2)) ; If not symbols, just multiply it
	(else (list m1 '* m2)))) ; Otherwise, return symbolic multiplication expression

; Check that it's a pair and if the star is in the middle
(define (product? x) (and (pair? x) (eq? (car (cdr x)) '*)))

; Multiplier is at the start since star is in the middle for infix
(define (multiplier p) (car p))

(define (multiplicand p) (caddr p))


;;; differentiation for exponents

(define (make-exponentiation x y)
  (cond ((= y 0) 1)
	((= y 1) x)
	(else (list x '** y))))

; Check that it's a pair and if the double star is in the middle
(define (exponentiation? x)
  (and (pair? x) (eq? (car (cdr x)) '**)))

; Base is at the start since double star is in the middle for infix
(define (base x) (car x))

(define (exponent x) (caddr x))

;;; deriv including exponentiation

(define (deriv exp var)
  (cond ((number? exp) 0)
	((variable? exp)
	 (if (same-variable? exp var) 1 0))
	((sum? exp)
	 (make-sum (deriv (addend exp) var)
		   (deriv (augend exp) var)))
	((product? exp)
	 (make-sum 
	  (make-product (multiplier exp)
			(deriv (multiplicand exp) var))
	  (make-product (deriv (multiplier exp) var)
			(multiplicand exp))))
	((exponentiation? exp)
	 (make-product (exponent exp)
		       (make-product (make-exponentiation (base exp) 
							  (- (exponent exp) 1))
				     (deriv (base exp) var))))
	(else
	 (error "unknown expression type -- DERIV" exp))))


