#lang r7rs
;; main file of the pacman project!
(import (scheme base)
        (pac-man-project draw-adt)
        (pac-man-project constants))




(define drawer (make-draw  window-width-px window-height-px))
(drawer 'draw-game!)
(define window (drawer 'get-window))
(define pacman (drawer 'get-pacman))


((window 'set-key-callback!)
 (lambda (type key)
   (if (eq? type 'pressed)
       (cond ((eq? key 'up) ((pacman 'direction!) 'up))
             ((eq? key 'down) ((pacman 'direction!) 'down))
             ((eq? key 'left) ((pacman 'direction!) 'left))
             ((eq? key 'right) ((pacman 'direction!) 'right))))))
 
((window 'set-update-callback!)
 (lambda (dt)
   (let* ((pos (pacman 'position))
          (cur-x (pos 'x))
          (cur-y (pos 'y))
          (dir (pacman 'direction)))
         
     (cond ((eq? dir 'up) ((pacman 'move!) cur-x (- cur-y pac-man-speed)))
           ((eq? dir 'down) ((pacman 'move!) cur-x (+ cur-y pac-man-speed)))
           ((eq? dir 'left) ((pacman 'move!) (- cur-x pac-man-speed)  cur-y))
           ((eq? dir 'right) ((pacman 'move!)(+ cur-x pac-man-speed) cur-y )))

     ((drawer 'sync-pacman!)))))
       
           
