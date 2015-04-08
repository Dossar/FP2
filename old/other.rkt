;; **********************************************************************
;; * THREE EXTRA BUTTONS - RUN NOW, SCHEDULER, ADDRESS BOOK
;; **********************************************************************

; Buttons for accesing the Address Book for email functionality
(define address-panel (new horizontal-panel%
                     (parent dialog)
                     (alignment '(center bottom))))

; Note that this is part of the functionality we'd want in the Add button for
; the Address Book. This is a bit misleading because the Address Book window
; has several options, but this functionality can be extended to make the add
; button work.
(new button%
     (parent address-panel)
     (label "Address Book")
     [callback (lambda (button event)
                 
                 ; Create new dialog window for Address Book
                 (define address-dialog (new frame% (label "Address Book")))
                 
                 ; Output textbox that will show the resulting test area file path.
                 (define email-panel (new horizontal-panel%
                                             (parent address-dialog)
                                             (alignment '(left top))))
                 
                 (define email-field (new text-field%
                                             (parent email-panel)
                                             (label "Email:")
                                             (min-width 400)))
                 
                 (send email-field set-value "Enter Email Address")
                 (send address-dialog show #t)
                 
                 ;; **********************************************************************
                 ;; * Buttons for determining to add or close email dialog window
                 ;; **********************************************************************
                 
                 (define control-panel (new horizontal-panel%
                                             (parent address-dialog)
                                             (alignment '(center bottom))))
                 
                 ; Ok button, for adding in an email
                 (new button%
                      (parent control-panel)
                      (label "Ok")
                 ) ; end Cancel button
                 
                 ; Close the dialog
                 (new button%
                      (parent control-panel)
                      (label "Cancel")
                      [callback (lambda (button event) (send address-dialog show #f))]
                 ) ; end Cancel button
                 
                 ) ; end lambda
               ] ; end callback
)


; Buttons for running the test suites
(define run-panel (new horizontal-panel%
                     (parent dialog)
                     (alignment '(center bottom))))

(new button%
     (parent run-panel)
     (label "Immediate Run"))

(new button%
     (parent run-panel)
     (label "Scheduled Run"))