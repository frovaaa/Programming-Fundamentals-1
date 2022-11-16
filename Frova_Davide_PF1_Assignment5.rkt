;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Frova_Davide_PF1_Assignment5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; ############ 2.1 Programming with lists ###########

; ###############################
; Exs. 1
; Design a function add-5 that takes a list of numbers and adds 5 to each of them.

; Data Types:
; a List<Number> is one of:
;  - '()                        ; Empty list
;  - (cons Number List<Number>)  ; NonEmpty List
; A list with inside an undefined number of Numbers

; Data Examples
; LON = List Of Numbers
(define LON1 '())
(define LON2 (list 3 5 7))
(define LON3 (list -5 15 3))

; Intepretation:
; Function that takes a list with n numbers inside and adds 5 to each of them

; Input / Output:
; add-5 : List<Number> -> List<Number>

; Header:
;(define (add-5 lon) LON1)

; Examples:
(check-expect (add-5 LON1) '())
(check-expect (add-5 LON2) (list 8 10 12))
(check-expect (add-5 LON3) (list 0 20 8))

; Template:
;(define (add-5 lon)
;  (cond
;    [(empty? lon) ...]
;    [else
;     (first lon)
;     (rest lon)
;     (add-5 (rest lon)) ...]))

; Code:
(define (add-5 lon)
  (cond
    [(empty? lon) '()]
    [else
     (cons (+ (first lon) 5) (add-5 (rest lon)))]))

; ###########################################
; Exs. 2

#|
Design a function add-title that takes a list of person names and a string
representing a title, and returns a list of the input names with the title added
as a prefix of every name.
For example, given the names "Strange", "Foster", and "Frankenstein" and the title "Dr.",
it outputs the strings "Dr. Strange", "Dr. Foster", and "Dr. Frankenstein".
|#


; Data Types:
; a List<String> is one of:
;  - '()                        ; Empty list
;  - (cons String List<String>)  ; NonEmpty List
; A list with inside some persons names (Strings)

; Data Examples

; Intepretation:
; Takes a List<String> and a Prefix and returns the names with the prefix added.

; Input / Output:
; add-title : List<String> String -> List<String>

; Header:
;(define (add-title los prefix) '())

; Examples:
(check-expect (add-title '() "Mr.") '())
(check-expect (add-title (list "Franco" "Albert" "Gino") "Dr.") (list "Dr. Franco" "Dr. Albert" "Dr. Gino"))
(check-expect (add-title (list "Mark" "Francesc" "Poseidon" "Dante") "") (list "Mark" "Francesc" "Poseidon" "Dante")) 

; Template:
;(define (add-title los prefix)
;  (cond
;    [(empty? los) ...]
;    [(= (string-length prefix) 0) ...]
;    [else (cons ... prefix ... (first los) (add-title (rest los) ... prefix))]))

; Code:
(define (add-title los prefix)
  (cond
    [(empty? los) '()]
    [(= (string-length prefix) 0) los]
    [else (cons (string-append prefix " " (first los)) (add-title (rest los)  prefix))]))


; ##############################
; Exs. 3

#|
Design a function min-list that returns the minimum number in a non-empty
list of numbers. (Note: you should not sort the input list to find the minimum.)
|#

; Data Types:
; A nonEmpty List of numbers is
; (cons Number List<Number>)  ; NonEmpty List
; In this case lon is the NonEmptyList<Number>

; Intepretation:
; The function min-list should return the minimum number in the non-empty list, without sorting it first

; Input / Output:
; min-list : nonEmptyList<Number> -> Number

; Header:
;(define (min-list lon) 0)

; Examples:
(check-expect (min-list (list 5 8 1 0 4 12)) 0)
(check-expect (min-list (list 12 8 32 25)) 8)
(check-expect (min-list (list -5 12 4 5)) -5)

; Template:
;(define (min-list lon)
;  (cond
;  [(empty? (rest lon)) ...]
;  [(< (first lon) (min-list (rest lon))) ...]
;  [else (min-list (rest lon))]))

; Code:
(define (min-list lon)
  (cond
    [(empty? (rest lon)) (first lon)]
    [(< (first lon) (min-list (rest lon))) (first lon)]
    [else (min-list (rest lon))]))

; ###########################
; Exs.4

#|
Design a function 2min-list that returns the two smallest numbers in a list of
numbers with at least two elements. (Note: you should not sort the input list
to find the two minim.)
|#

; Data Types:
; List<Number> is a list of Numbers
; require: The length of the list must be minimum 2
; The returned list is a List<Number> of length 2

; Intepretation:
; The function should return the two smallest numbers in the list

; Input / Output:
; 2min-list : List<Number> -> List<Number>

; Header:
;(define (2min-list lon) (list 0 3))

; Examples:
(check-expect (2min-list (list 0 5)) (list 0 5))
(check-expect (2min-list (list 4 0 5 1 2 12)) (list 0 1))

; Template:
;(define (2min-list lon)
;  (cond
;    [(= (length lon) 2) ...]
;    [(< (first lon) (min-list (rest lon))) ... (first lon) ... (min-list (rest lon) ...))]
;    [else (2min-list (rest lon))]))

; Code:
(define (2min-list lon)
  (cond
    [(= (length lon) 2) lon]
    [(< (first lon) (min-list (rest lon))) (list (first lon) (min-list (rest lon)))]
    [else (2min-list (rest lon))]))

; ###############################
; Exs. 5

#|
Design a function min-x that takes a non-empty list of Posn and outputs the
input’s element with the smallest x component. For example, given a list with
elements (5, 3), (3, 2), and (2, 3) it outputs (2, 3).
|#

; Data Types:

; Intepretation:

; Input / Output:

; Header:

; Examples:

; Template:

; Code:


















; Data Types:

; Intepretation:

; Input / Output:

; Header:

; Examples:

; Template:

; Code: