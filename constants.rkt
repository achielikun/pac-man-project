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
          distance-between-tiles
          score-area)

  (begin
    (define cel-width-px 23)
    (define cel-height-px 23)
    (define game-width 28)
    (define game-height 31)
    (define distance-between-tiles 2)
    ;; cel-height-px times a multiple for the score area
    (define score-area (* cel-height-px 3))
    ;; added one extra cel for the score location
    (define window-height-px (+ (* cel-height-px game-height) score-area))
    (define window-width-px (* cel-width-px game-width))


    
    (define pac-man-speed 0.2)
    
    (define ghost-speed 0.15)))


