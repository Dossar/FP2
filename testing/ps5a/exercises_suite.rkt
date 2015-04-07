#lang racket

(require rackunit)
(require "exercises.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite exercises
  #:before (lambda () (display "Starting Test Suite 'exercises'\n"))
  #:after (lambda () (display "Finished Test Suite 'exercises'\n"))
  (test-case "(accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))" (check-equal? (accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12))) '(22 26 30)))
  (test-case "p2_1" (check-equal? p2_1 #t))
  (test-case "p2_2" (check-equal? p2_2 #t))
  (test-case "p2_3" (check-equal? p2_3 #t))
  (test-case "p2_4" (check-equal? p2_4 #t))
  (test-case "p2_5" (check-equal? p2_5 #t))
  (test-case "p2_6" (check-equal? p2_6 #t))
  (test-case "p2_7" (check-equal? p2_7 #t))
  (test-case "(my-equal? '(this is a list) '(this is a list))" (check-equal? (my-equal? '(this is a list) '(this is a list)) #t))
  (test-case "(my-equal? '(this is a list) '(this (is a) list))" (check-equal? (my-equal? '(this is a list) '(this (is a) list)) #f))
  (test-case "(my-equal? '(1 (2 3) 4) '(1 (2 3) 4))" (check-equal? (my-equal? '(1 (2 3) 4) '(1 (2 3) 4)) #t))
  (test-case "(my-equal? 'a 'b)" (check-equal? (my-equal? 'a 'b) #f))
  (test-case "(my-equal? 'app 'app)" (check-equal? (my-equal? 'app 'app) #t))
  (test-case "p4" (check-equal? p4 #t))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define test-list (list
  exercises
))

(provide (all-defined-out))

