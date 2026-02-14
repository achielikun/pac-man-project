#lang r7rs


(define-library ()

  (import (scheme base)
          (pp1 graphics)
          (pacman constants))
  (export (make-draw))

  (begin

    (define (make-draw width  height  )
      (let ((window (make-window width  height "pac-man fase 1")))
        ((window 'set-background!) "black")

      (define pac-man-layer ((window 'new-layer!)))
      (define pac-man-tile #|image|#) 



      (define level-layer ((window 'new-layer!)))
      (define level-tile #|bitmap|# )


      (define coin-layer ((window 'new-layer!)))
      (define coin-tile #|image|#)

      (define ghost-layer ((window 'new-layer!)))
      (define red-ghost-tile #|image|#)
      (define blue-ghost-tile #|image|#)
      (define yellow-ghost-tile #|image|#)
      (define pink-ghost-tile #|image|#)
      

      (lambda (msg)
        (cond ((eq? msg 'start-draw!) start-draw!)
              (else (error "draw adt -- unknown message:" msg))))))))
          