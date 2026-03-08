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
   (let* ((pacman (drawer 'get-pacman))
          (pos (pacman 'position))
          (cur-x (pos 'x))
          (cur-y (pos 'y)))
     ((pacman 'move!) (+ cur-x 0.1) cur-y)
     ((drawer 'sync-pacman!)))))


