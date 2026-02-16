#lang r7rs


(define-library ()

  (import (scheme base)
          (pp1 graphics)
          (pac-man-project constants))
  (export make-draw)


  (begin

    (define (make-draw width  height)
      (let ((window (make-window width  height "pac-man phase 1")))
        ((window 'set-background!) "black")

      (define pac-man-layer ((window 'new-layer!)))
      (define pac-man-tile #|image|#) 



      (define level-layer ((window 'new-layer!)))
      (define level-tile #|bitmap|# )


      (define coin-layer ((window 'new-layer!)))
      (define coin-tile #|image|#)

 
      

      (lambda (msg)
        (cond ((eq? msg 'start-draw!) )
              (else (error "draw adt -- unknown message:" msg))))))))
          