#lang r7rs



(define-library ()
  (import (scheme base))

  (export cel-width-px
          cel-hight-px
          pac-man-speed
          ghost-speed)

  (begin
    (define cel-width-px 32)
    (define cel-hight-px 32)


  (define pac-man-speed 200)

  (define ghost-speed 200)))


