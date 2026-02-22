#lang r7rs

(define-library ()
  (import (scheme base))
  
  (begin
    (define  (make-maze)


      (define maze
        (vector 
         (vector 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x)))

      (define (at? pos)
        (let ((x (pos 'x))
              (y (pos 'y)))
          (vector-ref (vector-ref maze x) y)))

      (lambda (msg)
        (cond ((eq? msg 'at?) at?)
              (else (error "object adt -- unknown message :" msg)))))))
