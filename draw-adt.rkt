#lang r7rs


(define-library ()

  (import (scheme base)
          (pp1 graphics)
          (pac-man-project constants))
  (export make-draw)


  (begin

    (define (make-draw width  height)
      (let ((window (make-window width  height "pac-man phase 1" 300)))
        ((window 'set-background!) "black")

        (define (draw-object! obj tile)
          (let* ((pos (obj 'position))
                 (x (pos 'x))
                 (y (pos 'y))
                 (pos-x (* x cel-width-px))
                 (pos-y (* y cel-height-px)))
            ((tile 'set-x!) pos-x)
            ((tile 'set-y!) pos-y)))
        
        
          
        
        (define pac-man-layer ((window 'new-layer!)))
        (define pac-man-tile #|image|#) 
        
        
        
        (define level-layer ((window 'new-layer!)))
        (define wall-tile (make-tile cel-width-px cel-height-px ))
        ((wall-tile 'draw-rectangle!) 10 10 180 80 "blue")
        
        
        (define coin-layer ((window 'new-layer!)))
        (define coin-tile #|image|#)
        
        
        
        
        (lambda (msg)
          (cond ((eq? msg 'start-draw!) )
                (else (error "draw adt -- unknown message:" msg))))))))
