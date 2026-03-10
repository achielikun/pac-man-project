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
         (vector 'e 'l 'e 'e 'e 'e '() 'e 'e 'e 'x 'e 'e 'e 'e 'e 'e 'x 'e 'e 'e '() 'e 'e 'e 'e 'r 'e )
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
      
      
      (define (at? x y)
        (vector-ref (vector-ref maze y) x))
      
      (lambda (msg)
        (cond ((eq? msg 'at?) at?)
              ((eq? msg 'maze) maze)
              (else (error "object adt -- unknown message :" msg)))))))
