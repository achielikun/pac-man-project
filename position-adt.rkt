#lang r7rs


(define-library ()
  (import (scheme base))
  (export make-position)

  (begin
    ;;constructor of position object
    (define (make-position x y)

      
      ;;setter of position object
      (define (set-pos! new-x new-y)
        (set! x new-x)
        (set! y new-y))

      ;; dispatch lambda to create the object closure 
      (lambda (msg)
        (cond ((eq? msg 'x) x) ;;getter of the x cordinate
              ((eq? msg 'y) y) ;;getter of the y cordinate
              ((eq? msg 'set-pos!) set-pos!)
              (else (error "position adt -- unknown message:" msg)))))))
      
