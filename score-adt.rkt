#lang r7rs
(define-library ()
  (import (scheme base))
  (export make-score)
  (begin
    
    (define (make-score)
      (let ((score 0))

        (define (score+! x)
          (set! score (+ score x)))

        (lambda (msg)
          (cond ((eq? msg 'score+!) score+!)
                ((eq? msg 'score) score)
                (else (error "object adt  -- unknown message :" msg))))))))

