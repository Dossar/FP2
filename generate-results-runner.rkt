#lang racket/gui

;; Load in definitions from test-area-runner for procedures that create strings to write out to a file
;(require "test-area-runner.rkt")
(require "bn-to-racket.rkt") ; Windows/Unix filepath utilities

; We want to write a new file with the definitions of test-area-runner
; and has a require statement with the ps1_area.rkt file. This way that
; newly generated script will be in the same directory as the test area
; file and won't need to do any complex directory stuff. This is possibly
; Just a simple GUI that asks the user to browse the computer for the
; location of the test area file, then get the directory from there
; to create a new script that can run that area and generate the test
; results (and later on, to send an email).

;; **********************************************************************
;; * Procedures for writing a new file
;; **********************************************************************

;; Read in test results file to get its lines.
;(require "ps1_area.rkt")
;(define file-lines (file->lines "test_results.txt"))
;(define suite-name (get-results-suite-name file-lines))
;(define failed-case-lines-to-write (create-failed-cases-lines file-lines num-failed num-tests suite-name))
;(display-lines-to-file failed-case-lines-to-write "ps1_email.txt" #:separator"\n")

; Takes test area file directory to generate a new script in the same directory
; to be run on the tests and generate results. This will be placed after the
; loaded test-area-runner lines, so this will be at the end of the file
; e.g. area-filename is "ps1_area.rkt"
; e.g. test-area-dir is "C:\OPL\FP2\FP2\testing\ps1"
(define (create-run-script-lines test-area-dir area-filename)
  (define run-script-header (list "\n;; **********************************************************************"
                                  ";; * MAIN: RUN THE SCRIPT"
                                  ";; **********************************************************************"
                                  (string-append "\n;; This line will run the tests\n(require \"" area-filename "\")")
                                  "\n;; Read in the lines from the test results file"
                                  "(define file-lines (file->lines \"test_results.txt\"))"
                                  (string-append "(define failed-case-lines-to-write (create-failed-cases-lines "
                                                 "file-lines num-failed num-tests suite-name))")
                                  (string-append "(display-lines-to-file failed-case-lines-to-write "
                                                 "\"test_email.txt\" #:separator\"\\n\")")))
  run-script-header
)



;; **********************************************************************
;; * GUI
;; **********************************************************************

; Create a dialog window
(define dialog (new frame%
                         (label "Test-Results Script Generator")))

; Display simple message prompting user to enter input
(define description (string-append "Awaiting area file to generate a run script for."))

(define user-prompt (new message% [parent dialog]
                         [auto-resize #t]
                          [label description]))

; Assignment Source File Text Field and Button.
(define suite-panel (new horizontal-panel%
                     (parent dialog)
                     (alignment '(left top))))

(define suite-filepath (new text-field%
                         (parent suite-panel)
                         (label "Test Area File:")
                         (min-width 600)))

(send suite-filepath set-value "Click Browse and locate the test area file.")



(new button%
     (parent suite-panel)
     (label "Browse...")
     (callback (lambda (button event)
                 (define filepath (get-file))
                 (send suite-filepath set-value (path->string filepath)))))

;; **********************************************************************
;; * FILE CREATION CONVERT BUTTON
;; **********************************************************************

; Create the convert button
; Add click button to the horizontal panel
(new button% [parent dialog] [label "Make Run Script"]
      [callback (lambda (button event)

                  ;; Variables specifying test data                 
                  (define output-dir (get-dir-from-filepath (send suite-filepath get-value)))
                  (define area-file (string-append (get-assn-from-filepath (send suite-filepath get-value)) ".rkt"))
                  (define run-script-path (get-full-path output-dir "test" "_script.rkt"))
                  
                  ;; Run script lines to add with test-area-runner
                  (define test-area-runner-lines (file->lines "test-area-runner.rkt"))
                  (define run-script-lines (create-run-script-lines output-dir area-file))
                  (define all-run-script-lines (append test-area-runner-lines run-script-lines))
                  
                  ;; Write the lines out to the file
                  (define placeholder (remake-file run-script-path))
                  (display-lines-to-file all-run-script-lines run-script-path #:separator"\n")
                  
                  ;; Indicate to the user that the script was successfully created
                  (send user-prompt set-label (string-append "Created 'test_script.rkt' for "
                                                             "test area file '" area-file "'."))
                  
                                    ) ; end lambda
      ] ; end callback
) ;; end button
                  





; Show the dialog
(send dialog show #t)
