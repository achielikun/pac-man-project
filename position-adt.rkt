#lang r7rs


(define-library ()
  (import (scheme base))
  (export make-position)

  (begin

    (define (make-position x y)

      (define (set-pos! new-x new-y)
        (set! x new-x)
        (set! y new-y))

      (lambda (msg)
        (cond ((eq? msg 'x) x)
              ((eq? msg 'y) y)
              ((eq? msg 'set-pos!) set-pos!)
              (else (error "position adt -- unknown message:" msg)))))))
      
