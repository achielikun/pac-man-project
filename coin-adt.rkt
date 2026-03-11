#lang r7rs
(define-library ()

  (import (scheme base)
          (pac-man-project position-adt)
          (pac-man-project score-adt))
  (export make-coin))

  (begin
    
    ;;constructor of the coin object 
    (define (make-coin x y color)
      ;;coin object stores if its eaten, its value, its color and its position
      (let ((eaten #f)
            (value (cond ((eq? color 'red) 40)
                         ((eq? color 'green) 30)
                         ((eq? color 'blue) 25)
                         (else 10)))
            (pos (make-position x y)))

        ;;setter used to set the eaten variable to true so a coin can be seen as eaten and doesnt have to stay on the screen
        (define (eat!)
          (set! eaten #t))
        
      
        
        ;;dispatch lambda used for the creation of te object closure
        (lambda (msg)
          (cond ((eq? msg 'position) pos) ;;getter for the position
                ((eq? msg 'eaten?) eaten) ;;getter for the eaten state
                ((eq? msg 'value) value) ;;getter for the value
                ((eq? msg 'color) color) ;;getter for the color
                ((eq? msg 'eat!)(eat!)) ;;setter for the eaten state
                (else (error "object adt -- unknown message :" msg)))) )))
