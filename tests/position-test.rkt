#lang r7rs

(import (scheme base)
        (scheme write)
        (pp1 tests)
        (pac-man-project position-adt))

(define (position-test)

  (let ((p (make-position 15 20)))
    ;;check x and y
    (check-= (p 'x) 15 "position x should be at 15")
    (check-= (p 'y) 20 "position y should be at 20")
    ;;check postion set and then x and y
    ((p 'set-pos!) 20 15)
    (check-= (p 'x) 20 "position y should be at 20")
    (check-= (p 'y) 15 "position y should be at 20")))
;;run test
(run-test position-test "position ADT")

    
