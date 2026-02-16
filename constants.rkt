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
          window-height-px)

  (begin
    (define cel-width-px 30)
    (define cel-height-px 30)
    (define game-width 28)
    (define game-height 31)

    (define window-height-px (* cel-height-px game-height))
    (define window-width-px (* cel-width-px game-width))
    


  (define pac-man-speed 200)

  (define ghost-speed 200)))


