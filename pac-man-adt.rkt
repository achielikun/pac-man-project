#lang r7rs

(define-library ()
  (import (scheme base)
          (pac-man-project position-adt))
  
  (export make-pac-man)
  
  (begin

    ;;contructor of the pac-man object
    (define (make-pac-man x y)
      (let ((pos (make-position x y))
            (direction 'stop)
            (wish-direction 'stop))
        ;;move! procedure takes 2 number x and y as new cordinates to move the pacman to
        (define (move! new-x new-y )
          ((pos 'set-pos!) new-x new-y))
        
        
        ;;set direction changes the direction pacman moves in
        (define (set-direction! new-direction)
          (set! direction new-direction))
        ;;set wish direction changes the direction pacman wishes to move in
        (define (set-wish-direction! new-direction)
          (set! wish-direction new-direction))
        
        ;;dispatch lambda for the creation of the object closure 
        (lambda (msg)x
          (cond ((eq? msg 'position) pos) ;;getter for the position
                ((eq? msg 'direction) direction) ;;getter for the direction
                ((eq? msg 'set-direction!) set-direction!) ;;setter for the direction
                ((eq? msg 'wish-direction) wish-direction) ;;getter for the wished direction
                ((eq? msg 'set-wish-direction!) set-wish-direction!) ;;setter for the wished direction
                ((eq? msg 'move!) move!)
                (else (error "pac-man ADT -- unknown message:" msg))))))))
  
  
