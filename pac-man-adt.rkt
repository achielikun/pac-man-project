#lang r7rs

(define-library ()
  (import (scheme base))
  
  
  
  (begin
    (define (make-pac-man pos)
      (let ((direction 'left))
        
        (define (move!)
          ())
        
        
        
        (define (set-direction! new-direction)
          (set! direction new-direction))
                
        
        
        
        (lambda (msg)
          (cond ((eq? msg 'direction!) set-direction!)
                ((eq? msg 'move!) (move!))
                ((else (error "pac-man ADT -- unknown message:" msg))))))))
  
  
