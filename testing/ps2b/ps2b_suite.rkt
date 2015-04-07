#lang racket

(require rackunit)
(require "ps2b.rkt")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite ps2b
  #:before (lambda () (display "Starting Test Suite 'ps2b'\n"))
  #:after (lambda () (display "Finished Test Suite 'ps2b'\n"))
  (test-case "(* (product1 pi-term 1 next 6) 4)" (check-equal? (* (product1 pi-term 1 next 6) 4) 4096/1225))
  (test-case "(product2 pi-term 1 next 6)" (check-equal? (product2 pi-term 1 next 6) 1024/1225))
  (test-case "(sum square 2 inc 4)" (check-equal? (sum1 square 2 inc 4) 29))
  (test-case "(* (product pi-term 1 next 6) 4)" (check-equal? (* (product pi-term 1 next 6) 4) 4096/1225))
  (test-case "(((double (double double)) inc) 5)" (check-equal? (((double (double double)) inc) 5) 21))
  (test-case "((compose square inc) 6)" (check-equal? ((compose square inc) 6) 49))
  (test-case "((expnt-iter 2) 3)" (check-equal? ((expnt-iter 2) 3) 9))
  (test-case "((repeat square 2) 5)" (check-equal? ((repeat square 2) 5) 625))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define test-list (list
  ps2b
))

(provide (all-defined-out))

