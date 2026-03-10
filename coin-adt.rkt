#lang r7rs
(define-library ()

  (import (scheme base)
          (pac-man-project position-adt)
          (pac-man-project score-adt))
  (export make-coin))

  (begin


    (define (make-coin x y)
      (let ((eaten #f)
            (pos (make-position x y)))
        
        (define (eat!)
          (set! eaten #t))
        
      
        

        (lambda (msg)
          (cond ((eq? msg 'position) pos)
                ((eq? msg 'eaten?) eaten)
                ((eq? msg 'eat!)(eat!))
                (else (error "object adt -- unknown message :" msg)))) )))
