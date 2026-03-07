#lang r7rs
;; main file of the pacman project!
(import (scheme base)
        (pac-man-project draw-adt)
        (pac-man-project constants))




(define drawer (make-draw  window-width-px window-height-px))
(drawer 'draw-game!)
(define window (drawer 'get-window))

((window 'set-update-callback!)
 (lambda (dt)
   (let* ((pos (pac-pos 'position))
          (cur-x (pos 'x)))
     ((pac-pos 'move!) (+ cur-x 0.1) (pos 'y)))
   (drawer 'sync-pacman!)))


