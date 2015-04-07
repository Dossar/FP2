#lang racket

;; +++++++++++++++ Required for auto grading ++++++++++++++++++++++++++++
(define nil '())

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

;; **********************************************************************
;;
;; 1. Assume that we want to develop an inventory database for an
;; online CD store.  
;;
;; For each CD, the database stores its title, artist, price, how many
;; copies are in stock, and its category of music (such as rock,
;; blues, or country).  
;;
;; Write a data definition for CD inventories. When completing the
;; following exercises, please make sure to use map, filter, and
;; accumulate (aka, reduce) as much as reasonable.  
;; 
;; 1a. Create a constructor procedure with parameters, title, artist,
;; price, category, and units-in-stock, and corresponding accessors to
;; retrieve these fields.  
;; 
;; 1b. Populate an inventory (i.e., a list) with 10 or so records
;; created from your constructor.  
;;
;; 1c. Write a procedure all-titles that consumes an inventory and
;; produces a list of all titles in the inventory.  
;; 
;; 1d. Write a procedure titles-in-stock that consumes an inventory
;; and produces a list of all titles in the inventory with at least 1
;; copy in stock.  
;;
;; 1e. Write a procedure restock that consumes a CD title, number of
;; new copies of that CD and an inventory and produces an inventory in
;; which the named CD has the given number of additional copies (and
;; all other CDs remain the same).  
;; 
;; 1f. Write a procedure titles-by that consumes an artist name and
;; inventory and produces a list of titles of CDs by that artist.
;; 
;; 1g. Write a procedure copies-in-stock that consumes a CD title,
;; artist name and an inventory and produces the number of copies of
;; that item that are in stock.  Return 0 if the named CD isn't in the
;; inventory.
;; 
;; 1h. Write a procedure blues-sale that consumes an
;; inventory and produces an inventory in which all blues CDs are
;; discounted by 10%.
;; 
;; 1i. Write a procedure carry-cd? that consumes a
;; title and artist name and produces a boolean indicating whether
;; that item is in the inventory (whether in or out of stock).
;;
;; This problem is courtesy of a lab exercise from WPI's Scheme
;; course.

; Answer:
;;;;;;;;;;1a.
;Constructors
; model the db as a list of records.
(define cdDB '() )

;Each record is a list of (title artist price category units-in-stock)
(define (make-record title artist price category units-in-stock)
  'foo)

; Insert one record into the database, by rebinding the global symbol
; cdDB to a new list with the new record appended.
; don't change this code
(define (insert-record rec)
  (set! cdDB (append cdDB (list rec))))

; Selectors
; these should retrieve the appropriate item from the record-list.
; remember these are procedures.
(define (title rec)
  "The White Album")

(define (artist rec)
  "The Beatles")

(define (price rec)
  18.99)

(define (category rec)
  'rock)

(define (units-in-stock rec)
  17)

;;;;;;;1b.

;insert a bunch of records.
;see examples in file "freds-db.rkt"
;make sure to submit that file back for autograding.
;but you should put your own here!!
(insert-record (make-record "Facelift" "Alice in Chains" 12.98 'rock 7))

;;;;;;;1c.
; all-titles
; map the title operator over the db.
(define (all-titles db)
  'foo)

;;;;;;1d.
; titles-in-stock
; filter the db for units-in-stock being more than 0,
; then map the title operator over it.
(define (titles-in-stock db)
  'foo)

;;;;;;;1e.
; restock
; map a fcn over the database that returns either:
;  a new record with the num of copies increased by the restock count, or
;  just the existing record (if title doesn't match
(define (restock this-title num-copies db)
  'foo)

;;;;;;;;1f.
; titles-by
; filter the db by matching on artist, then map title over it.
(define (titles-by this-artist db)
  'foo)

;;;;;;;;1g.
; copies-in-stock
; filter by by matching title and artist, then apply units-in-stock to it.
; make sure to deal with the case of the record not existing in the DB
(define (copies-in-stock this-title this-artist db)
  'foo)

;;;;;;;;1h. 
; blues-sale
; map a fcn over the db that either:
;  outputs a new record with adjusted price (if category is blues), or
;  just outputs the existing record
(define (blues-sale db)
  'foo)

;;;;;;;;1i.
; carry-cd?
; filter the db for a matching record,
; then return a boolean if units-in-stock is more than 0.
; make sure to deal with the case of the record not existing in the DB
(define (carry-cd? this-title this-artist db)
  #f)




;; **********************************************************************
;;
;; 2. Consider the following procedure for operating on trees:
(define (tree-manip tree init leaf accum) 
  (cond ((null? tree) init) 
        ((not (pair? tree)) (leaf tree)) 
        (else (accum  
               (tree-manip (car tree) init leaf accum) 
               (tree-manip (cdr tree) init leaf accum)))))

;; Suppose that we provide a test tree, 
(define test-tree '(1 (2 (3 (4) 5) 6) 7))
;;
;; 2a. Write the parameters to tree-manip that will count the number
;;     of leaves in the tree, evaluating to 7 for test-tree; e.g.:
;;     (tree-manip test-tree <param1> <param2> <param3>). (Figure out
;;     the three parameters.)
;;
;; 2b. Write the parameters to tree-manip that will add the values of
;;     the leaves in the tree, evaluating to 28 for test-tree.
;;
;; 2c. Write the parameters to tree-manip that will triple each of the
;;     values in test-tree, evaluating to (3 (6 (9 (12) 15) 18) 21).

;; Answer:
;2a.
(define (count-leaves tree) 
  1)

;2b.
(define (sum-leaves tree) 
  1)

;2c.
(define (triple-leaves tree) 
  1)

;; **********************************************************************
;;
;; 3. SICP exercise 2.35 (pp. 120), another way of implementing
;; count-leaves as an accumulation.  Fill in the below procedure.
;;
;; uncomment line starting with "accumumlate" and replace with answer

(define (count-leaves-with-map t)
;;  (accumulate '<??> '<??> (map '<??> '<??>)))
  13)


;; **********************************************************************
;;
;; 4. Using flip, negate, and compose.
;;
;;     4a. Define and play with the functions flip, negate, and
;;     compose, as they are defined below.
;;
;;     4b. Define, for instance, a flipped cons function and a flipped
;;     minus function.
;;
;;     4c. Define the function odd? in terms of even? and negate.

(define (flip f)
  (lambda (x y)
    (f y x)))

(define (negate p)
  (lambda (x) 
    (if (p x) #f #t)))

(define (compose f g)
  (lambda (x)
    (f (g x))))

;;Answer:
;3.b 
(define (flip-cons lst1 lst2)  
  0)

(define (flip-minus x y)  
  0)

;3.c
(define (flip-odd x)
  0)

;; **********************************************************************
;;
;; 5. SICP exercise 2.38 (pp. 121), introducing fold-right and fold-left.
;;
;; Write the defintion for fold-right (hint: Answer to fold-right is
;; in the question. Read the question carefully)
;;
;; Write down each step of substitution in comment line for each of
;; the following.
;;
;; What are the values of
;(fold-right / 1 (list 1 2 3))
;(fold-left / 1 (list 1 2 3))
;(fold-right list nil (list 1 2 3))
;(fold-left list nil (list 1 2 3))

;;Answer:
;; Given in the question that accumulate is also known as fold-right. So,
(define (fold-right op initial sequence) 
  1)

;(fold-right / 1 (list 1 2 3))
;write substitution steps

;(fold-left / 1 (list 1 2 3))
;write substitution steps

;(fold-right list nil (list 1 2 3))
;write substitution steps

;(fold-left list nil (list 1 2 3))
;write substitution steps

;op property:
;--------------
;write the property (with example if possible)

;After answering the above replace #f to #t
(define p4 #f)


;; **********************************************************************
;;
;; 6. Use fold-right to define the function bucket. 
;;
;; It consumes a list of numbers, and returns a list of sublists of
;; adjacent equal numbers.
;;
;; For example:
;; (bucket '(1 1 2 2 2 3 1 1 1 2 3 3)) –> 
;;  '((1 1) (2 2 2) (3) (1 1 1) (2) (3 3))
;;
;; PLEASE NOTE
;; it's trivial to find the answer for this on the internet
;; please do not succumb
;; you won't learn very much unless you struggle with it
;;
;; think about each of the two objects that are consumed by the 
;; folding function as the fold proceeds
;;
;; and think about what sort of object should be produced by that
;; function 
;; 
;; Fill in the below procedure
(define (bucket lst)
  lst);

;; ************************ END OF FILE *********************************
(provide (all-defined-out))
