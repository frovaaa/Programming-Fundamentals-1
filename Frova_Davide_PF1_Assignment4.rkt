;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Frova_Davide_PF1_Assignment4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; ########## Canvas #########
; The canvas is an IMAGE made by the use of the rectangle function of Racket, with a width, heigth and color.
; This will be our background/canvas of the application
(define CANVAS (rectangle 1280 720 "solid" "pink"))
; ###########################

; ########## line-points ##########
; Data types
; a LinePoints is a Struct that contains:
;             - startPoint : Posn (x,y) values
;             - endPoint   : Posn (x,y) values
;             - pen        : racket-default Pen which contains the color and type of line
; A line-points is a Struct that contains 2 Posn (x,y positions) and a PEN constant (racket default type for PEN, that contains colors and sizes)

; Header of struct
(define-struct line-points [startPoint endPoint pen])

; Examples of Data
; ---Pens---
(define PEN1 (make-pen "purple" 10 "solid" "round" "round"))
(define PEN2 (make-pen "white" 10 "solid" "round" "round"))
(define PEN3 (make-pen "orange" 10 "solid" "round" "round"))
(define PEN4 (make-pen "red" 10 "solid" "round" "round"))
; ----------
; #################################

; ########## Maybe<Line> ##########
; A Maybe<Line> is one of
;           - line-points
;           - #false
; A Maybe<Line> can be a Line which is being drawn onto the canvas
; #false if we are not drawing (the line is missing)
;
; The Line cointains the specs of the line such as color, width, ecs., also the Start and End posn (x,y coordinates)

; Examples of Data
(define LINE1 (make-line-points (make-posn 40 75) (make-posn 95 150) PEN1))
(define LINE2 (make-line-points (make-posn 321 327) (make-posn 300 412) PEN2))
(define LINE3 #false)

; #################################

; ########## AppState #############
; An AppState is a Structure with the following elements:
;            drawingCanvas: Image with eventually the lines added to it. (Background + lines)
;            Maybe<Line>  :
;                       - Line
;                       - #false
;            quit         : Boolean value that indicates if the application has been stopped or not (with the key 'q')
;                       - #true -> Application will quit
;                       - #false -> Application is running
; The AppState is the constant that keeps track of everything happening in the drawing application,
; it's like a screenshot of the situation in a given moment, those moments can differ by having a line drawn,
; canceling the placing of a line on top of the drawingCanvas, quitting the application.

; Header of the Struct
(define-struct app-state [drawingCanvas Maybe<Line> quit])

; Examples of Data
(define APPSTATE1 (make-app-state CANVAS LINE1 #false))
(define APPSTATE2 (make-app-state CANVAS LINE2 #true))
(define APPSTATE3 (make-app-state CANVAS LINE3 #false))
; ####################################################

; ################ IS THE APPSTATE Maybe<Line> A LINE or BOOLEAN? ########
; Data types
; AppState : Defined before

; Interpretation
; The function isBooleanMaybe<Line>? is a checker function that takes as input
; the AppState and check if the Maybe<Line> in it is not present (boolean value (#false))

; Input/Output
; isBooleanMaybe<Line>? : AppState -> Boolean

; Header
;(define (isBooleanMaybe<Line>? appState) #true)

; Examples
(check-expect (isBooleanMaybe<Line>? APPSTATE1) #false)
(check-expect (isBooleanMaybe<Line>? APPSTATE2) #false)
(check-expect (isBooleanMaybe<Line>? APPSTATE3) #true)

; Template
;(define (isBooleanMaybe<Line> appState)
;  (if ... appState... #true))

; Code
(define (isBooleanMaybe<Line>? appState)
  (if (boolean? (app-state-Maybe<Line> appState)) #true #false))
  

; ################ ADD LINE OF APPSTATE TO APPSTATE-CANVAS ###############
; Data types
; This function takes as input an AppState (defined before)

; Intepretation
; This function will take an app-state as input, take the Maybe<Line> (corresponding to a Line)
; and uses the built-in add-line function to add at the specified positions (start and end)
; the line to the drawingCanvas of the app-state

; Input/Output
; add-line-to-canvas : AppState -> AppState

; Header
; (define (add-line-to-canvas appState) APPSTATE3)

; Examples
(check-expect (add-line-to-canvas APPSTATE1) (make-app-state (add-line (app-state-drawingCanvas APPSTATE1) 40 75 95 150 PEN1) #false #false))
(check-expect (add-line-to-canvas APPSTATE2) (make-app-state (add-line (app-state-drawingCanvas APPSTATE2) 321 327 300 412 PEN2) #false #true))
(check-expect (add-line-to-canvas APPSTATE3) APPSTATE3)

; Template

;(define (add-line-to-canvas appState)
;  (if app-state-Maybe<Line> is #false) appState
;  (else ... make-app-state ...))

; Code

(define (add-line-to-canvas appState)
  (if (isBooleanMaybe<Line>? appState) appState ;Check not used as I check this before in the handler function, but for the tests is necessary
      (make-app-state
       (add-line (app-state-drawingCanvas appState)
                 (posn-x (line-points-startPoint (app-state-Maybe<Line> appState)))
                 (posn-y (line-points-startPoint (app-state-Maybe<Line> appState)))
                 (posn-x (line-points-endPoint (app-state-Maybe<Line> appState)))
                 (posn-y (line-points-endPoint (app-state-Maybe<Line> appState)))
                 (line-points-pen (app-state-Maybe<Line> appState))
                 )
       #false
       (app-state-quit appState)
       )))

; ############################################

; ############## DRAW FUNCTION ###############
; Data types
; The draw function takes as input an app-state defined before

; Intepretation
; This function has the objective of drawing/showing the current canvas/background that is
; stored inside the AppState given as input. This function is used by the big-bang function.
; The function draw will add (if present) the current line to the canvas temporarly, to show were the
; line will be placed if the user decides to confirm it's creation and then show the updated canvas.
; This function is used by the Big Bang function

; Input/Output
; draw : AppState -> Image

; Header
; (define (draw appState) CANVAS)

; Examples
(check-expect (draw APPSTATE1) (app-state-drawingCanvas (add-line-to-canvas APPSTATE1))) ; AppState with Maybe<Line> set to a LinePoints
(check-expect (draw APPSTATE2) (app-state-drawingCanvas (add-line-to-canvas APPSTATE2))) ; AppState with Maybe<Line> set to a LinePoints
(check-expect (draw APPSTATE3) (app-state-drawingCanvas APPSTATE3))                      ; AppState with Maybe<Line> set to #false

; Template
;(define (draw appState)
;  (if ... appState ...
;      ...app-state-drawingCanvas...
;      ...app-state-Maybe<Line>...
;      ...app-state-quit...
;      ))

; Code
(define (draw appState)
  (if (isBooleanMaybe<Line>? appState)
      (app-state-drawingCanvas appState)
      (app-state-drawingCanvas (add-line-to-canvas appState))
      ))

; ################################################

; ############## START DRAWING ##############
; Data types
; AppState has been defined before
; x-mouse : Number - x position of the mouse
; y-mouse : Number - y position of the mouse

; Intepretation
; The function start-drawing is used to set as Line the Maybe<Line> of the given AppState,
; in the LinePoints there will be set the start and end position as the current mouse coordinates

; Input/Output
; start-drawing : AppState Number Number -> AppState

; Header
; (define (start-drawing appState x-mouse y-mouse) APPSTATE3)

; Examples
(check-expect (start-drawing APPSTATE3 150 200)
              (make-app-state (app-state-drawingCanvas APPSTATE3)
                              (make-line-points (make-posn 150 200) (make-posn 150 200) PEN1)
                              (app-state-quit APPSTATE3)))
; Template
;(define (start-drawing appState x-mouse y-mouse)
;  ... app-state-drawingCanvas ...
;  ... x-mouse ...
;  ... y-mouse ...
;  ... app-state-quit...
;  ... app-state-Maybe<Line> ...
;  )

; Code
(define (start-drawing appState x-mouse y-mouse)
  (make-app-state (app-state-drawingCanvas appState)
                  (make-line-points (make-posn x-mouse y-mouse) (make-posn x-mouse y-mouse) PEN1)
                  (app-state-quit appState)))

; #####################################################

; ############## CHANGE APPSTATE ENDLINE ##############
; Data types
; AppState defined before
; x-mouse : Number representing the X current coordinate of the mouse
; y-mouse : Number representing the X current coordinate of the mouse

; Intepretation
; The move-end function is used to change the endline position of the Maybe<Line> in the given
; AppState with the given x and y coordinates

; Input/Output
; move-end : AppState Number Number -> AppState

; Header
; (define (move-end appState x-mouse y-mouse) APPSTATE1)

; Examples
(check-expect (move-end APPSTATE1 300 250)           ; APPSTATE with a Maybe<Line> as LinePoints
              (make-app-state
               (app-state-drawingCanvas APPSTATE1)
               (make-line-points
                (make-posn
                 (posn-x (line-points-startPoint (app-state-Maybe<Line> APPSTATE1)))
                 (posn-y (line-points-startPoint (app-state-Maybe<Line> APPSTATE1))))
                (make-posn
                 300
                 250)
                (line-points-pen (app-state-Maybe<Line> APPSTATE1)))
               (app-state-quit APPSTATE1)
               ))
(check-expect (move-end APPSTATE3 300 250) APPSTATE3) ; AppState with Maybe<Line> as #false

; Template
;(define (move-end appState x-mouse y-mouse)
;  ... app-state-drawingCanvas ...
;  ... app-state-Maybe<Line> ...
;  ... app-state-quit ...
;  ... x-mouse ...
;  ... y-mouse ...)

; Code
(define (move-end appState x-mouse y-mouse)
  (if (isBooleanMaybe<Line>? appState) appState
      (make-app-state
       (app-state-drawingCanvas appState)
       (make-line-points
        (make-posn
         (posn-x (line-points-startPoint (app-state-Maybe<Line> appState)))
         (posn-y (line-points-startPoint (app-state-Maybe<Line> appState))))
        (make-posn
         x-mouse
         y-mouse)
        (line-points-pen (app-state-Maybe<Line> appState)))
       (app-state-quit appState)
       )))

; ############################################

; ############## MOUSE HANDLER ###############
; Data types
; AppState    : Defined before
; x-mouse     : Number - x value of the mouse position
; y-mouse     : Number - y value of the mouse position
; mouse-event : string value (racket set of strings)

; Intepretation
; The handle-mouse function defines the operations to do for each action
; done with the mouse during the run of the application.
; In this case we detect the following situations:
; button down (left button)                   -> Start drawing the line, set the start point of the Maybe<Line> in the app-state
; drag (mouse dragging with left button down) -> Continuosly change the endingPoint of the Maybe<Line> in the app-state
; button-up (mouse left button released)      -> Ending of the drawing phase of the line, the final endPoint is set, the line is added to the drawingCanvas and the
;                                                Maybe<Line> is set to #false
; This function is used by the Big Bang function

; Input/Output
; handle-mouse : app-state x-mouse y-mouse mouse-event -> AppState

; Header
; (define (handle-mouse appState x-mouse y-mouse mouse-event) APPSTATE1)

; Examples
(check-expect (handle-mouse APPSTATE3 125 32 "button-down") (start-drawing APPSTATE3 125 32))                            ; AppState with Maybe<Line> as #false starting to draw
(check-expect (handle-mouse APPSTATE1 125 32 "drag") (move-end APPSTATE1 125 32))                         ; AppState with Maybe<Line> as LinePoints drawing
(check-expect (handle-mouse APPSTATE3 125 32 "drag") APPSTATE3)                                                          ; AppState with Maybe<Line> as #false drawing (canceled)
(check-expect (handle-mouse APPSTATE1 125 32 "button-up") (add-line-to-canvas (move-end APPSTATE1 125 32))); AppState with Maybe<Line> as LinePoints ending the drawing

; Template
;(define (handle-mouse appState x-mouse y-mouse mouse-event)
;  (cond
;    [(string=? "button-down" mouse-event) ...appState... x-mouse.... y-mouse...]
;    [(isBooleanMaybe<Line>? appState) ...appState...]
;    [(string=? "drag" mouse-event) ... appState ... x-mouse ... y-mouse]
;    [(string=? "button-up" mouse-event) ... appState ... x-mouse ... y-mouse]
;    [else ...appState...]
;    ))

; Code
(define (handle-mouse appState x-mouse y-mouse mouse-event)
  (cond
    [(string=? "button-down" mouse-event) (start-drawing appState x-mouse y-mouse)]
    [(isBooleanMaybe<Line>? appState) appState]
    [(string=? "drag" mouse-event) (move-end appState x-mouse y-mouse)]
    [(string=? "button-up" mouse-event) (add-line-to-canvas (move-end appState x-mouse y-mouse))]
    [else appState]
    ))

; ###########################

; ######### QUIT? ###########
; Data Types
; quit? is a function that returns a Boolean value
; Interpretation: quit? is a function that returns #true or #false
; based on the boolean value quit of the app-state given as input

; Input/Output
; quit? : AppState -> Boolean

; Header
; (define (quit? appState) #true)

; Examples
(check-expect (quit? APPSTATE1) #false)
(check-expect (quit? APPSTATE2) #true)
(check-expect (quit? APPSTATE1) #false)

; Template
;(define (quit? appState
;   (if ...appState... )))

; Code

(define (quit? appState)
  (if (app-state-quit appState) #true #false)) ; We could check with a comparison if it's true or not, but it's not necessary

; ###############################
; ######### CANCEL LINE #########
; Data Types
; AppState: Defined before

; Interpretation
; This function takes an AppState and change the Maybe<Line? to #false if it is set to a LinePoints
; It's called when we press 'escape' while drawing a new line

; Input/Output
; cancel-line : AppState -> AppState

; Header
;(define (cancel-line appState) APPSTATE1)

; Examples
(check-expect (cancel-line APPSTATE1) (make-app-state (app-state-drawingCanvas APPSTATE1) #false #false))
(check-expect (cancel-line APPSTATE3) APPSTATE3)

; Template
;(define (cancel-line appState)
;  (if ... app-state-Maybe<Line>...))

; Code
(define (cancel-line appState)
  (if (isBooleanMaybe<Line>? appState) appState (make-app-state (app-state-drawingCanvas appState) #false #false)))

; ###############################

; ############# QUIT ############
; Data types
; AppState : Defined before

; Intepretation
; This function sets to #true the value of quit inside the given AppState

; Input/Output
; quit : AppState -> AppState

; Header
;(define (quit appState) APPSTATE1)

; Examples
(check-expect (quit APPSTATE1) (make-app-state (app-state-drawingCanvas APPSTATE1) (app-state-Maybe<Line> APPSTATE1) #true))
(check-expect (quit APPSTATE2) APPSTATE2)
(check-expect (quit APPSTATE3) (make-app-state (app-state-drawingCanvas APPSTATE3) (app-state-Maybe<Line> APPSTATE3) #true))

; Template
;(define (quit appState)
;  (if ...appState...))

; Code
(define (quit appState)
  (if (app-state-quit appState) appState (make-app-state (app-state-drawingCanvas appState) (app-state-Maybe<Line> appState) #true)))

; ###############################

; ######### KEY HANDLER #########
; Data types
; AppState   : defined before
; key-pressed : String (rappresenting the key pressed)

; Intepretation
; The handle-key function decides what function to call in the occasion that a key of the keyboard is pressed
; The handled key in this application are:
;                                          - q      -> Quit the application
;                                          - escape -> Cancel the current line drawing

; Input/Output
; handle-key : AppState key-pressed -> AppState

; Header
; (define (handle-key appState key-pressed) APPSTATE3)

; Examples
(check-expect (handle-key APPSTATE1 "escape") (make-app-state (app-state-drawingCanvas APPSTATE1) #false #false))
(check-expect (handle-key APPSTATE3 "q") (make-app-state (app-state-drawingCanvas APPSTATE3) (app-state-Maybe<Line> APPSTATE3) #true))
(check-expect (handle-key APPSTATE3 "escape") (make-app-state (app-state-drawingCanvas APPSTATE3) #false #false))
(check-expect (handle-key APPSTATE2 "1") (change-pen APPSTATE2 PEN1)) ; Additional feature

; Template
;(define (handle-key appState key-pressed)
;  (cond
;    [(string=? "q" key-pressed) (quit... appState ...)]
;    [(string=? "escape" key-pressed) (cancel-line... appState ...)]
;    [else ...appState...]))

; Code
(define (handle-key appState key-pressed)
  (cond
    [(string=? "q" key-pressed) (quit appState)]
    [(string=? "escape" key-pressed) (cancel-line appState)]
    [(and                                                     ; This part is an additional feature that I implemented,  you can change the type of line while you are dragging
      (boolean=? (boolean? (get-pen key-pressed)) #false)     ; I used the key-pressed as string to make the implementation completely parametric 
      (boolean=? (isBooleanMaybe<Line>? appState) #false))    ; This means that if you add a line in the function get-pen, you can assign any key to a pen without
     (change-pen appState (get-pen key-pressed))]             ; changing this piece of code
    [else appState]))

; ########################

; ######## BIG BANG#######
; Data types
; initial-state : AppState

; Intepretation
; The drawing-app function uses the big-bang function that is predefine in racket, it takes a WorldState (in this case AppState) and
; handles the various handlers to start and execute the drawing application

; Input/Output
; drawing-app : AppState -> AppState

; Header
;(define (drawing-app initial-state) APPSTATE3)

; Template
;(define (drawing-app initial-state)
;  (big-bang initial-state
;    [to-draw ...initial-state...]
;    [on-mouse ...initial state...handle-mouse...]
;    [on-key ... initial-state...handle-key...]
;    [stop-when ...initial-state...quit?]))

; Code

(define (drawing-app initial-state)
  (big-bang initial-state
    [to-draw draw]
    [on-mouse handle-mouse]
    [on-key handle-key]
    [stop-when quit?]))

; #######################


; ############################################# ADDITIONAL FUNCTIONS NOT LISTED IN THE ASSIGNMENT ######################################################

; I want that when I press 1 2 or 3 the color of the line currently drawn changes,
; the initial idea was to select first a color and then the following lines would be of that color, but to achieve that I should make an important change in the recipe
; of AppState that would reflect in changes in all the code (adding a new constant with the PEN value) Instead I'm going to use the PEN constant in the Maybe<Line> that
; I already implemented.
; By doing that only the current drawing line will be affected.
; To achieve this I need to add some handlers in the key-handler and call a new Enumerator function to retreive the new PEN
; Using this function is easy to add new PENS, you just create the new PEN and add it to the Enumaration

; ####### GET PEN #######
; Data types
; the get-pen is an Enumeration with the following elements:
;            - "1" -> PEN1
;            - "2" -> PEN2
;            - "3" -> PEN3
; A pen is a Racket default data type that contains color, type, size, ecc, specs applied to a Line.

; Interpretation
; This function returns the PEN corresponding to the String given as input
; It takes as input a String, but in reality it will be a key-event given by the key-handler function

; Input/Output
; get-pen : String ->
;                    - pen    - If the pen is found in the Enumeration
;                    - #false - If the requested pen doesn't exist

; Header
;(define (get-pen key) PEN1)

; Examples
; In this case the last example needs to be changed if we add another PEN as PEN9 (used 9 to don't change the check-expect immediately)
; As described in the key-handle function you can actually assign any key to the pens, obviously you can't use the keys (escape, q)

; ~~~~~~~~~~ HOW TO ADD A PEN ~~~~~~~~~~~
; To add a Pen simply add it's definition in the Pens section (top of the file or down here near PEN5), then add a cond case and choose the key binded to the pen
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(check-expect (get-pen "1") PEN1)
(check-expect (get-pen "2") PEN2)
(check-expect (get-pen "3") PEN3)
(check-expect (get-pen "4") PEN4)
(check-expect (get-pen "9") #false)

; Template
;(define (get-pen key)
;  (cond
;   [(string=? "1" key) ... ]
;   [(string=? "2" key) ... ]
;   [(string=? "3" key) ... ]
;   [else ... ]))

; Code
(define (get-pen key)
  (cond
    [(string=? "1" key) PEN1 ]
    [(string=? "2" key) PEN2 ]
    [(string=? "3" key) PEN3 ]
    [(string=? "4" key) PEN4 ]
    [(string=? "5" key) PEN5 ]
    [else #false ]))

; ---Pens---
(define PEN5 (make-pen "cyan" 10 "solid" "butt" "round"))

; ############### CHANGE PEN ###############
; Data types
; a Pen is a Racket default data type explained before
; an AppState has been defined before

; Interpretation
; This function takes an app-state and changes the current pen of the app-state-Maybe<Line> to the new pen in input

; Input/Output
; change-pen : AppState pen -> AppState

; Header
;(define (change-pen appState pen) APPSTATE1)

; Examples
(check-expect (change-pen APPSTATE1 PEN2)
              (make-app-state (app-state-drawingCanvas APPSTATE1)
                              (make-line-points
                               (line-points-startPoint (app-state-Maybe<Line> APPSTATE1))
                               (line-points-endPoint (app-state-Maybe<Line> APPSTATE1))
                               PEN2)
                              (app-state-quit APPSTATE1)
                              ))

; Template
;(define (change-pen appState pen)
;  (... appState-Maybe<Line>... pen ...))

; Code
(define (change-pen appState pen)
  (make-app-state (app-state-drawingCanvas appState)
                  (make-line-points
                   (line-points-startPoint (app-state-Maybe<Line> appState))
                   (line-points-endPoint (app-state-Maybe<Line> appState))
                   pen)
                  (app-state-quit appState)
                  ))


; After I defined the get-pen function I needed to modify the key-handle function to match the new selection system

; #################################################################################################################################
