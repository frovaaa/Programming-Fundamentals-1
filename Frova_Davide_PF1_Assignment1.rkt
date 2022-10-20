;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Frova_Davide_PF1_Assignment1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; 2.1 Expressions and basic types

; 2.1.1
(define H1 5) ; Hours of the first week and so on
(define H2 8)
(define H3 12)
(define H4 10)
(define TOTAL-HOURS (+ H1 H2 H3 H4)) ; Sum of all the hours

; 2.1.2
(define N-WEEKS 4) ; Total amount of weeks
(define AVERAGE-HOURS (/ TOTAL-HOURS N-WEEKS)) ; Average hours for week

; 2.1.3

; Distance traveled and time (in minutes) in the first segment
(define S1 80)
(define T1-M 22)

; Distance traveled and time (in hours) in the second segment
(define S2 120)
(define T2-H 1)

; Distance traveled and time (in hours and minutes) in the third segment
(define S3 90)
(define T3-H 1)
(define T3-M 20)

; Constant for the conversion from minutes to hours
(define CONV-MIN-HRS 60)

; Total distance traveled in km
(define DISTANCE-TRAVELED
  (+ (* S1 (/ T1-M CONV-MIN-HRS))
     (* S2 T2-H)
     (* S3 (+ T3-H (/ T3-M CONV-MIN-HRS)))))

; Same result but with a function for the convertion instead

; Definition of the function to convert the minutes to hours
(define (MINUTES->HOURS MIN)
  (/ MIN CONV-MIN-HRS))

; Total distance traveled in km using the convertion function
(define DISTANCE-TRAVELED-v2
  (+
   (* S1 (MINUTES->HOURS T1-M))
   (* S2 T2-H)
   (* S3 (+ T3-H (MINUTES->HOURS T3-M)))))

; 2.1.4
#| Is a standard pizza’s price per square centimeter greater or less than a
baby pizza’s price per square centimeter? |#

(define PIZZA-STANDARD-PRICE 12) ; Standard pizza price in CHF
(define PIZZA-STANDARD-DIAM 33)  ; Standard pizza diameter in cm

(define PIZZA-BABY-PRICE 9) ; Baby pizza price in CHF
(define PIZZA-BABY-DIAM 18)  ; Baby pizza diameter in cm

; Function to calculate the area of a circle given it's diameter
(define (DIM->AREA DIM)
  (/ (* pi DIM DIM) 4))

; Comparison of the two results, checking if standard is < then baby
(define STANDARD-BETTER?
  (< (/ PIZZA-STANDARD-PRICE (DIM->AREA PIZZA-STANDARD-DIAM))
     (/ PIZZA-BABY-PRICE (DIM->AREA PIZZA-BABY-DIAM))))

; 2.1.5

; Defining the strings
(define HELLO "Hello ")
(define ME "Davide")
(define WELCOME ", welcome to PF1!")

; Combining the 3 strings into one
(define HI-TO-ME (string-append HELLO ME WELCOME))

; 2.1.6
; I will use the 2 const HELLO and WELCOME from the point 2.1.5

(define (greet NAME)
  (string-append HELLO NAME WELCOME))

; 2.2

; Drawing the Give way sign
(define SIGN-GIVE-WAY (rotate 180 (overlay
 (triangle 70 "solid" "white")
 (triangle 100 "solid" "red"))))

; Drawing the Dead end sign
; First version of the sign, without knowing that the above function even existed

(define SIGN-DEAD-END-v1
  (underlay (rectangle 100 100 "solid" "blue")
            (overlay/offset
             (rectangle 70 25 "solid" "red")
             0 35
             (rectangle 30 95 "solid" "white"))))

; Drawing the Dead end using above function, after reading the Hints
(define SIGN-DEAD-END-v2
  (underlay (rectangle 100 100 "solid" "blue")
            (above (rectangle 70 25 "solid" "red")
                   (rectangle 30 60 "solid" "white"))))
