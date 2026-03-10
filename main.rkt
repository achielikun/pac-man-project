#lang r7rs
;; main file of the pacman project!
(import (scheme base)
        (pac-man-project draw-adt)
        (pac-man-project constants)
        (pac-man-project maze-adt))




(define drawer (make-draw  window-width-px window-height-px))
(drawer 'draw-game!)
(define window (drawer 'get-window))
(define pacman (drawer 'get-pacman))

(define maze (make-maze))
(define wish-dir 'stop)
(define actual-dir 'stop)


(define (try-turn? dir x y)
  (and (eq? (pacman 'wish-direction) dir) (collision-check? x y)))

(define (collision-check2? next-x next-y)
  (let* ((grid-x (exact next-x))
         (grid-y (exact next-y)))
    (if (and (>= grid-x 0) (>= grid-y 0) (< grid-x game-width) (< grid-y game-height))
        (not (eq? ((maze 'at?) grid-x grid-y) 'x))
        #f)))

(define (collision-check? next-x next-y)
  (let* ((radius 0.4)
         (left (exact (round (- next-x radius))))
         (right (exact (round  (+ next-x radius))))
         (top (exact (round (- next-y radius))))
         (bottom (exact (round (+ next-y radius)))))

    
    (and (not (eq? ((maze 'at?) left top) 'x))
         (not (eq? ((maze 'at?) right top) 'x))
         (not (eq? ((maze 'at?) left bottom) 'x))
         (not (eq? ((maze 'at?) right bottom) 'x)))))

((window 'set-key-callback!)
 (lambda (type key)
   (if (eq? type 'pressed)
       (cond ((eq? key 'up) ((pacman 'wish-direction!) 'up))
             ((eq? key 'down) ((pacman 'wish-direction!) 'down))
             ((eq? key 'left) ((pacman 'wish-direction!) 'left))
             ((eq? key 'right) ((pacman 'wish-direction!) 'right))))))
 
((window 'set-update-callback!)
 (lambda (dt)
   (let* ((pos (pacman 'position))
          (cur-x (pos 'x))
          (cur-y (pos 'y)))
         

     (let* ((pos (pacman 'position))
            (gx (exact (round (pos 'x))))
            (gy (exact (round ( pos 'y))))
            (cell ((maze 'at?) gx gy)))


       (cond ((and (eq? cell 'r) (eq? (pacman 'direction) 'right)) ((pacman 'move!) 0 (pos 'y)))
             ((and (eq? cell 'l) (eq? (pacman 'direction) 'left)) ((pacman 'move!) (- game-width 1) (pos 'y)))))
         

     (cond 
       ((try-turn? 'up  cur-x (- cur-y pac-man-speed)) ((pacman 'direction!) 'up) ((pacman 'move!) cur-x cur-y))
       ((try-turn? 'down  cur-x  (+ cur-y pac-man-speed)) ((pacman 'direction!) 'down)  ((pacman 'move!) cur-x cur-y))
       ((try-turn? 'left  (- cur-x pac-man-speed)   cur-y) ((pacman 'direction!) 'left)  ((pacman 'move!) cur-x  cur-y))
       ((try-turn? 'right  (+ cur-x pac-man-speed)  cur-y ) ((pacman 'direction!) 'right)  ((pacman 'move!) cur-x  cur-y)))
     (let ((dir (pacman 'direction)))
       
       (cond ((eq? dir 'up) (if (collision-check?   cur-x  (- cur-y pac-man-speed)) ((pacman 'move!)  cur-x (- cur-y pac-man-speed))))
             ((eq? dir 'down) (if (collision-check?  cur-x  (+ cur-y pac-man-speed)) ((pacman 'move!)  cur-x (+ cur-y pac-man-speed))))
             ((eq? dir 'left) (if (collision-check? (- cur-x pac-man-speed)   cur-y) ((pacman 'move!) (- cur-x pac-man-speed)  cur-y)))
             ((eq? dir 'right) (if (collision-check?  (+ cur-x pac-man-speed)  cur-y ) ((pacman 'move!)(+ cur-x pac-man-speed)  cur-y) )))
     ((drawer 'sync-pacman!))))))
 
           
