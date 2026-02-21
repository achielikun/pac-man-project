#lang r7rs
(define-library ()

  (import (scheme base)
          (pp1 graphics))


  (begin


    (define (make-coin pos))


    (lambda (msg)
      (cond ((eq? msg 'position) pos)
            (else (error "object adt -- unknown message :" msg))))
    ))
