;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Frova_Davide_PF1_Assignment2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Assignment 2 Frova Davide

;##########
; Exs. 1
; Write a data type definition for a length (in centimeters or inches)

;; Data types
; a Length is a Number
; interpretation: a Length is in Centimiters or in Inches

;##########
;Exs. 2
; Design a function inch->cm that converts a length in inches to centimeters.
; (One inch is 2.54 centimeters: define a constant for the conversion factor.)

;; Data types
; Already defined in Exs.1

;; Input/Output
; inch->cm: Length -> Length
; convert Inches lengths 'inch' to Centimiters

; header
;(define (inch->cm inch) inch)

; Examples
(check-expect (inch->cm 5) 12.7)
(check-expect (inch->cm 1) 2.54)

;; Template
;(define (inch->cm inch)
;  (... inch ...)

;;Code
; Convertion constant
(define inch-cm-const 2.54)

(define (inch->cm inch)
  (* inch inch-cm-const))

;##########
; Exs. 3
; Design a function mean/4 that computes the average of four numbers.

;; Data types
; Four Numbers that can have any value
; Resulting average will be also a Number
; Interpretation: four numbers of any value

;; Input/Output
; mean/4: Numbers -> Number
; Calculate the average value of four numbers

; Header
;(define (mean/4 num1 num2 num3 num4) 0)

;; Examples
(check-expect (mean/4 4 5 8 9) 6.5)
(check-expect (mean/4 1 4 7 0) 3)

;; Template
;(define (mean/4 num1 num2 num3 num4)
;  (... num1 num2 num3 num4 ...))

;; Code
(define (mean/4 num1 num2 num3 num4)
  (/ (+ num1 num2 num3 num4) 4))

;##########
; Exs. 4
; Design a function area-triangle that computes the area of a triangle given the
; length of its base and height.

;; Data types
; Lenght of base and height are Numbers
; Resulting area will be a Number
; Interpretation: Height and Base are in a non specified unit of mesure,
;                 but both are the same unit.

;; Input/Output
; area-triangle: Base & Height -> Area
; Resulting area of a triangle from Base and Height

;Header
;(define (area-triangle base height) 0)

; Examples
(check-expect (area-triangle 4 3) 6)
(check-expect (area-triangle 2 5) 5)
(check-expect (area-triangle 1 6) 3)

; Template
;(define (area-triangle base height)
;  (... base height ...)

; Code
(define (area-triangle base height)
  (/ (* base height) 2))

;##########
; Exs. 5
#|
A perfect square is a an integer that is also the square of another integer. For
example, 4 is a perfect square, whereas 8 is not. Design a function perfect-square?
that returns #true if its input is a perfect square, and #false otherwise. (Hint:
the square root of a perfect square is an integer.)
|#

;; Data Types
; The value in input is a Number, the result of the check is a Boolean value
; Interpretation: Checking a number for perfect square means that you input a Number
;                 And the result of the operation gives you a #true or #false response if it's a perfect square

;; Input/Output
; perfect-square?: Number -> Boolean
; Check if the number is a perfect square

; Header
;(define (perfect-square? number) #true)

; Examples
(check-expect (perfect-square? 6) #false)
(check-expect (perfect-square? 4) #true)

; Template
;(define (perfect-square? number)
;  (... number ...))

; Code
(define (perfect-square? number)
  (= (* (sqrt number) (sqrt number)) number))

;##########
; Exs. 6
; Write a data type definition for a price (in CHF)

;; Data types
; A Price (in CHF) is a Number
; Interpretation: A price, in this case with the CHF currency, is a Number

;##########
; Exs. 7
#|
A store has toilet paper on sale: if you buy up to 6 rolls, you pay the regular
price of 2 francs per roll; if you buy up to 20 rolls, you get a 10% discount on
the regular price; if you buy more than 20 rolls, you get a 15% discount on the
regular price. Design a function final-price that computes how much you pay
for any given number of toilet paper rolls.

n <= 6      : 2n
6 < n <= 20 : 2n - 10%
20 < n      : 2n - 15%
|#

;; Data types
; A Price (in CHF) and the rolls are a Number
; A discount is a percentage of the Price

;; Input/Output
; final-price: Number -> Number
; final price for the number of toilet papers with discount applicated
;header
;(define (final-price rolls) 0)

; Examples
(check-expect (final-price 4) 8)
(check-expect (final-price 15) 27)
(check-expect (final-price 35) 59.5)

;; Template
;(define (final-price rolls)
;  (cond
;    [(rolls <= 6) ... rolls ...]
;    [(rolls <= 20) ... rolls ...]
;    [(else) ... rolls ...]))

;; Code

; Cost of a single roll o paper
(define roll-cost 2)

(define (final-price rolls)
  (cond
    [(<= rolls 6) (* rolls roll-cost)]
    [(<= rolls 20) (- (* rolls roll-cost) (* (/ (* rolls roll-cost) 100) 10))]
    [else (- (* rolls roll-cost) (* (/ (* rolls roll-cost) 100) 15))]))

;##########
; Exs. 8
#|
Design a function neo-latin->english that inputs the name of a note in the Cmajor scale
using neo-Latin naming and outputs the same note using English
naming. The neo-Latin names (used, for example, in Italy and France) are
do, re, mi, fa, sol, la, and si; the corresponding English names are C, D, E, F, G, A, B.
|#

;; Data types
; A Note is a String, neo-latin names are:
; - Do
; - Re
; - Mi
; - Fa
; - Sol
; - La
; - Si
; 
; Intepretation: Notes are Strings corresponding to the neo-latin names

;; Input / Output
; neo-latin->english: String -> String
; Convertion from neo-latin name to the corresponding English Name
; Header:
;(define (neo-latin->english note) "")

;; Examples
(check-expect (neo-latin->english "Re") "D")
(check-expect (neo-latin->english "Sol") "G")
(check-expect (neo-latin->english "Si") "B")

;; Template
;(define (neo-latin->english note)
;  (cond
;    [(string=? "Do" note) (... "" ...)]
;    [(string=? "Re" note) (... "" ...)]
;    [(string=? "Mi" note) (... "" ...)]
;    [(string=? "Fa" note) (... "" ...)]
;    [(string=? "Sol" note) (... "" ...)]
;    [(string=? "La" note) (... "" ...)]
;    [(string=? "Si" note) (... "" ...)]))

;; Code
(define (neo-latin->english note)
  (cond
    [(string=? "Do" note) "C"]
    [(string=? "Re" note) "D"]
    [(string=? "Mi" note) "E"]
    [(string=? "Fa" note) "F"]
    [(string=? "Sol" note) "G"]
    [(string=? "La" note) "A"]
    [(string=? "Si" note) "B"]))

;##########
; Exs. 9
#|
Design a function quarter->angle that takes a time in quarter hours (an integer
in the interval between 0 included and 4 excluded),and returns the angle (in
degrees) of a clock’s minute hand indicating that quarter.
Angles are computed counter-clockwise from 0 (horizontal to the right) to 360.
At 0 quarter hours, the minute hand should point straight up (90 degrees);
at 1 quarter hours, it should point to the right (0 degrees);
at 2 quarter hours, it should point down (270 degrees);
at 3 quarter hours, it should point to the left (180 degrees).
|#

; Data types
; A Time is a Number
; - 0
; - 1
; - 2
; - 3
; The Angle is a Number
; Intepretation: A Time is a Number between 0 included and 4 excluded which
;                corresponds to a quarter of a clock.
;                The result will be in an Angle in Degrees from 0 to 360

;; Input / Output
; quarter->angle: Time -> Angle
; Converts from Quarter indication to Angle in degrees (of a clock minute hand)
; Header:
;(define (quarter->angle quart) 0)

;; Examples
(check-expect (quarter->angle 0) 90)
(check-expect (quarter->angle 1) 0)
(check-expect (quarter->angle 2) 270)
(check-expect (quarter->angle 3) 180)

;; Template
;(define (quarter->angle quart)
;  (cond
;    [(= 0 quart) (... 0 ...)]
;    [(= 1 quart) (... 0 ...)]
;    [(= 2 quart) (... 0 ...)]
;    [(= 3 quart) (... 0 ...)]))

;; Code
(define (quarter->angle time)
  (cond
    [(= 0 (modulo time 4)) 90]
    [(= 1 (modulo time 4)) 0]
    [(= 2 (modulo time 4)) 270]
    [(= 3 (modulo time 4)) 180]))

;##########
; Exs. 10
#|
Design a function clock-minutes that takes a time in quarter hours
(any nonnegative integer, not necessarily less than 4) and returns an image of a clock
with the minute hand placed at the appropriate position.
The function’s implementation should use function quarter->angle you defined above.
|#

;; Data types
; A Time is a Number
; An Angle is a Number
; A Clock is an image with the Minutes hand
; The Minutes Hand is an Image
; Interpretation: The given Time value can be any nonnegative integer,
;                 The resulting angle will be between 0 and 360 an will correspond to
;                 a quarter hour position. The Minute Hand is an image pointing to the
;                 corresponding quarter hour.

;; Input / Output
; clock-minutes: Time -> Image
; The function takes in a Time and generates an image of the clock
; with the minutes hand pointing to the corresponding quarter hour

;; IMAGE CONSTANTS

; Clock Background Diameter
(define CLOCK-BG-DIAMETER 40)
; Clock Background Image
(define CLOCK-BG (circle CLOCK-BG-DIAMETER "solid" "black"))
; Minutes Hand Lenght
(define HAND-LENGHT 35)
; Minutes Hand Width
(define HAND-WIDTH 5)
; Minutes Hand with Pointy triangle on top rotated with the initial offset
(define MINUTES-HAND (rotate -90 (above (triangle 10 "solid" "white") (rectangle HAND-WIDTH HAND-LENGHT "solid" "white"))))

; Header:
;(define (clock-minutes time) CLOCK-WITH-HAND)

;; Examples
(check-expect (clock-minutes 0)
              (overlay/offset (rotate 90 MINUTES-HAND) 0 (/ HAND-LENGHT 2) CLOCK-BG))

(check-expect (clock-minutes 1)
              (overlay/offset (rotate 0 MINUTES-HAND) (* (/ HAND-LENGHT 2) -1) 0 CLOCK-BG))

(check-expect (clock-minutes 2)
              (overlay/offset (rotate 270 MINUTES-HAND) 0 (* (/ HAND-LENGHT 2) -1) CLOCK-BG))

(check-expect (clock-minutes 3)
              (overlay/offset (rotate 180 MINUTES-HAND) (/ HAND-LENGHT 2) 0 CLOCK-BG))

;; Template
;(define (clock-minutes time)
;  (cond
;    [(= 0 time) (... quarter->angle MINUTES-HAND CLOCK-BG...)]
;    [(= 1 time) (... quarter->angle MINUTES-HAND CLOCK-BG...)]
;    [(= 2 time) (... quarter->angle MINUTES-HAND CLOCK-BG...)]
;    [(= 3 time) (... quarter->angle MINUTES-HAND CLOCK-BG...)]))

;; Code
(define (clock-minutes time)
  (cond
    [(= 0 (modulo time 4)) (overlay/offset (rotate (quarter->angle time) MINUTES-HAND) 0 (/ HAND-LENGHT 2) CLOCK-BG)]
    [(= 1 (modulo time 4)) (overlay/offset (rotate (quarter->angle time) MINUTES-HAND) (* (/ HAND-LENGHT 2) -1) 0 CLOCK-BG)]
    [(= 2 (modulo time 4)) (overlay/offset (rotate (quarter->angle time) MINUTES-HAND) 0 (* (/ HAND-LENGHT 2) -1) CLOCK-BG)]
    [(= 3 (modulo time 4)) (overlay/offset (rotate (quarter->angle time) MINUTES-HAND) (/ HAND-LENGHT 2) 0 CLOCK-BG)]))
