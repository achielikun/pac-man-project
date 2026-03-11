#lang r7rs

(import (scheme base)
        (scheme write)
        (pp1 tests)
        (pac-man-project maze-adt))


(define (maze-test)

  (let ((maze (make-maze)))
    ;; check if cell at 1,1 isnt a wall
    (check (not (eq? ((maze 'at?) 1 1) 'x)) "cel at 1,1 should not be a wall")
    ;;set 1,1 to empty istead of coin
    ((maze 'set-cell!) 1 1 'e)
    (check-eq? ((maze 'at?) 1 1) 'e "changed call to e so 1,1 should be e")))
;;run test
(run-test maze-test "maze ADT")


    

