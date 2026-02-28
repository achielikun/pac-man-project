#lang r7rs



(define-library ()
  (import (scheme base))

  (export cel-width-px
          cel-height-px
          pac-man-speed
          ghost-speed
          game-width
          game-height
          window-width-px
          window-height-px
          distance-between-tiles)

  (begin
    (define cel-width-px 23)
    (define cel-height-px 23)
    (define game-width 28)
    (define game-height 31)
    (define distance-between-tiles 3)
    
    ;; added one extra cel for the score location
    (define window-height-px (+ (* cel-height-px game-height) cel-height-px))
    (define window-width-px (* cel-width-px game-width))
    


  (define pac-man-speed 200)

  (define ghost-speed 200)))


