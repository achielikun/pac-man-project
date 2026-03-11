#lang r7rs
(define-library ()

  (import (scheme base)
          (pac-man-project position-adt)
          (pac-man-project score-adt))
  (export make-coin))

  (begin

    


    
    
    (define (make-coin x y color)
      (let ((eaten #f)
            (value (cond ((eq? color 'red) 40)
                         ((eq? color 'green) 30)
                         ((eq? color 'blue) 25)
                         (else 10)))
            (pos (make-position x y)))
        
        (define (eat!)
          (set! eaten #t))
        
      
        

        (lambda (msg)
          (cond ((eq? msg 'position) pos)
                ((eq? msg 'eaten?) eaten)
                ((eq? msg 'value) value)
                ((eq? msg 'color) color)
                ((eq? msg 'eat!)(eat!))
                (else (error "object adt -- unknown message :" msg)))) )))
