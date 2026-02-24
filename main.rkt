#lang r7rs
;; main file of the pacman project!
(import (scheme base)
        (pac-man-project draw-adt)
        (pac-man-project constants))




(define game (make-draw  window-height-px window-width-px))

(game 'draw-maze!)
