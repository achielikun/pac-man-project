#lang r7rs
;; main file of the pacman project!
(import (scheme base)
        (scheme write)
        (pac-man-project draw-adt)
        (pac-man-project constants)
        (pac-man-project maze-adt)
        (pac-man-project score-adt))




(define drawer (make-draw  window-width-px window-height-px))
(drawer 'draw-game!)
(define window (drawer 'get-window))
(define pacman (drawer 'get-pacman))

(define maze (make-maze))
(define wish-dir 'stop)
(define actual-dir 'stop)

(define paused? #f)


(define score (make-score))
;;help procedure for collision
(define (try-turn? dir x y)
  (and (eq? (pacman 'wish-direction) dir) (collision-check? x y dir)))


        


;;help procedure for ty-turn
(define (collision-check? next-x next-y dir)
  (let* ((radius 0.4)
         (get-safe-cell (lambda (nx ny)
                          ((maze 'at?) (modulo (exact  (round nx)) game-width) (modulo (exact (round ny)) game-height))))
         (left (- next-x radius))
         (right  (+ next-x radius))
         (top  (- next-y radius))
         (bottom  (+ next-y radius))
         (cell (get-safe-cell next-x next-y)))
    
    ;;wall check
    (and (not (eq? (get-safe-cell left top) 'x))
         (not (eq? (get-safe-cell right top) 'x))
         (not (eq? (get-safe-cell left bottom) 'x))
         (not (eq? (get-safe-cell right bottom) 'x))
         ;;one way street check
         ;;only check when there isnt a wall in the way
         (let ((is-one-way? (or (eq? cell 'u)
                                (eq? cell 'd) 
                                (eq? cell 'l) 
                                (eq? cell 'r))))
           
           
           (if is-one-way?
               (cond ((eq? cell 'u) (eq? dir 'up))
                     ((eq? cell 'd) (eq? dir 'down))
                     ((eq? cell 'l) (eq? dir 'left))
                     ((eq? cell 'r) (eq? dir 'right))
                     (else #t))
               
              #t )))))
  




((window 'set-key-callback!)
 (lambda (type key)
   (if (eq? type 'pressed)
       (cond ((eq? key 'up) ((pacman 'wish-direction!) 'up))
             ((eq? key 'down) ((pacman 'wish-direction!) 'down))
             ((eq? key 'left) ((pacman 'wish-direction!) 'left))
             ((eq? key 'right) ((pacman 'wish-direction!) 'right))
             ((eq? key 'escape) #|(display "escape pressed") (newline)|# (set! paused? (not paused?)) ((drawer 'toggle-pause-screen!) paused?))))))
 
((window 'set-update-callback!)
 (lambda (dt)
   (if (not paused?)
       (let* ((pos (pacman 'position))
              (cur-x (pos 'x))
              (cur-y (pos 'y))
              (gx (modulo (exact (round (pos 'x))) game-width))
              (gy (modulo (exact (round ( pos 'y))) game-height))
              (cell ((maze 'at?) gx gy)))
            
         
         (if (null? cell)
         (begin
           ((maze 'set-cell!) gx gy 'e)
           
           ((drawer 'hide-coin!) gx gy)))
           
           
           #| (display "eaten at:") (display gx) (display ".") (display gy) (newline))|#
         
         
         (cond ((and (eq? cell 'tr) (eq? (pacman 'direction) 'right)) (begin ((pacman 'move!) 0 cur-y) (set! cur-x 0)))
               ((and (eq? cell 'tl) (eq? (pacman 'direction) 'left)) (begin ((pacman 'move!) (- game-width 1) cur-y) (set! cur-x (- game-width 1)))))
         
         ;;check collision
         (cond 
           ((try-turn? 'up  cur-x (- cur-y pac-man-speed)) ((pacman 'direction!) 'up) ((pacman 'move!) cur-x cur-y))
           ((try-turn? 'down  cur-x  (+ cur-y pac-man-speed)) ((pacman 'direction!) 'down)  ((pacman 'move!) cur-x cur-y))
           ((try-turn? 'left  (- cur-x pac-man-speed)   cur-y) ((pacman 'direction!) 'left)  ((pacman 'move!) cur-x  cur-y))
           ((try-turn? 'right  (+ cur-x pac-man-speed)  cur-y ) ((pacman 'direction!) 'right)  ((pacman 'move!) cur-x  cur-y)))
         
         ;;move pacman
         (let ((dir (pacman 'direction)))
           
           (cond ((eq? dir 'up) (if (collision-check?   cur-x  (- cur-y pac-man-speed) 'up) ((pacman 'move!)  cur-x (- cur-y pac-man-speed))))
                 ((eq? dir 'down) (if (collision-check?  cur-x  (+ cur-y pac-man-speed) 'down) ((pacman 'move!)  cur-x (+ cur-y pac-man-speed))))
                 ((eq? dir 'left) (if (collision-check? (- cur-x pac-man-speed)   cur-y 'left) ((pacman 'move!) (- cur-x pac-man-speed)  cur-y)))
                 ((eq? dir 'right) (if (collision-check?  (+ cur-x pac-man-speed)  cur-y 'right ) ((pacman 'move!)(+ cur-x pac-man-speed)  cur-y))))
           ((drawer 'sync-pacman!))))))
 )

 
((window 'set-draw-callback!)
  (lambda () #t))
