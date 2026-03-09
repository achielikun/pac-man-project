#lang r7rs

(define-library ()
  (import (scheme base)
          (pac-man-project position-adt))
  
  (export make-pac-man)
  
  (begin
    (define (make-pac-man x y)
      (let ((pos (make-position x y))
            (direction 'stop))
        
        (define (move! new-x new-y )
          ((pos 'set-pos!) new-x new-y))
        
        
        
        (define (set-direction! new-direction)
          (set! direction new-direction))
        
        
        
        
        (lambda (msg)
          (cond ((eq? msg 'position) pos)
                ((eq? msg 'direction) direction)
                ((eq? msg 'direction!) set-direction!)
                ((eq? msg 'move!) move!)
                (else (error "pac-man ADT -- unknown message:" msg))))))))
  
  
