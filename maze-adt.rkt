#lang r7rs

(define-library ()
  (import (scheme base))
  (export make-maze)
  (begin
    ;;constructor of the maze object 
    (define  (make-maze)

      ;;local variable storing the grid matrix of the playing field 
      (define maze
        ;; 'x for a wall
        ;; '() for a coin
        ;; 'p for the start location of pacman
        ;; 'u, 'd,'l, 'r for the oneway halls
        ;; 'e for empty a place where there is nothing
        ;; 'tl 'tr stand for teleport right, left used for the warping at the end of the map
        (vector
         (vector 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() '() '() 'x )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'x 'x 'x 'e 'x 'x 'e 'x 'x 'x 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'x 'x 'x 'e 'x 'x 'e 'x 'x 'x 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'e 'e 'e 'e 'e 'e 'e 'e 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'e 'tl 'e 'e 'e 'e '() 'e 'e 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'e 'e '() 'e 'e 'e 'e 'tr 'e )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'x 'x 'x 'x 'x 'x 'x 'x 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'e 'e 'e 'e 'e 'e 'e 'e 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'x 'x 'x 'x 'x 'x 'x 'x 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'e 'x 'x 'x 'x 'x 'x 'x 'x 'e 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'u 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'u 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() 'x 'x '() '() '() '() '() '() '() '() 'p '() '() '() '() '() '() '() 'x 'x '() '() '() 'x )
         (vector 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x )
         (vector 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x )
         (vector 'x '() '() '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x )
         ))
      
      ;;used to get the symbol at location x,y 
      (define (at? x y)
        (vector-ref (vector-ref maze y) x))
      ;; used to set the location of x,y to a different symbol
      (define (set-cell! x y cell)
        (vector-set! (vector-ref maze y) x cell))
        
      ;;dispatch lambda used for the creation of the object closure
      (lambda (msg)
        (cond ((eq? msg 'at?) at?) ;;getter of symbol at location x,y
              ((eq? msg 'set-cell!) set-cell!) ;;setter of symbol at x,y
              ((eq? msg 'maze) maze) ;;getter for the grid matrix
              (else (error "object adt -- unknown message :" msg)))))))
