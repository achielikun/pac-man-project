#lang r7rs
(define-library ()
  (import (scheme base))
  (export make-score)
  (begin
    ;;contructor of the score object
    (define (make-score)
      ;;score stores one local variable its own score
      (let ((score 0))
        ;;setter used to increase the score by x amount assuming x is a number
        (define (score+! x)
          (set! score (+ score x)))
        ;;dispatch lambda used for the creation of the object closure
        (lambda (msg)
          (cond ((eq? msg 'score+!) score+!) ;;setter of the score
                ((eq? msg 'score) score) ;;getter of the score 
                (else (error "object adt  -- unknown message :" msg))))))))

