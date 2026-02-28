#lang r7rs

(define-library ()
  (import (scheme base))
  (export make-maze)
  (begin
    (define  (make-maze)

      
      (define maze
        (vector
         (vector 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() '() '() 'x )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'x 'x 'x 'e 'x 'x 'e 'x 'x 'x 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'x 'x 'x 'e 'x 'x 'e 'x 'x 'x 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'e 'e 'e 'e 'e 'e 'e 'e 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'e 'e 'e 'e 'e 'e '() 'e 'e 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'e 'e '() 'e 'e 'e 'e 'e 'e )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'x 'x 'x 'x 'x 'x 'x 'x 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'e 'e 'e 'e 'e 'e 'e 'e 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'e 'e 'e 'e 'e 'x '() 'x 'x 'e 'x 'x 'x 'x 'x 'x 'x 'x 'e 'x 'x '() 'x 'e 'e 'e 'e 'e )
         (vector 'x 'x 'x 'x 'x 'x '() 'x 'x 'e 'x 'x 'x 'x 'x 'x 'x 'x 'e 'x 'x '() 'x 'x 'x 'x 'x 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x 'x '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x '() 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() 'x 'x '() '() '() '() '() '() '() '() 'p '() '() '() '() '() '() '() 'x 'x '() '() '() 'x )
         (vector 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x )
         (vector 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x '() 'x 'x 'x )
         (vector 'x '() '() '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() 'x 'x '() '() '() '() '() '() 'x )
         (vector 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x )
         (vector 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x 'x '() 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x '() 'x )
         (vector 'x '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() '() 'x )
         (vector 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x 'x )
         ))
      
      
      (define (at? pos)
        (let ((x (pos 'x))
              (y (pos 'y)))
          (vector-ref (vector-ref maze x) y)))
      
      (lambda (msg)
        (cond ((eq? msg 'at?) at?)
              ((eq? msg 'maze) maze)
              (else (error "object adt -- unknown message :" msg)))))))
