#lang r7rs

(import (scheme base)
        (scheme write)
        (pp1 tests)
        (pac-man-project pac-man-adt))


(define (pac-man-test)
  ;;set initial position to 10,10
  (let ((pacman (make-pac-man 10 10)))
    (let ((pos (pacman 'position)))
      ;;test position
      (check-eq? (pos 'x) 10 "initual x should be 10")
      (check-eq? (pos 'y) 10 "initual y should be 10")
      ;;test direction

      (let ((set-dir! (pacman 'set-direction!)))
        (set-dir! 'up)
        (check-eq? (pacman 'direction) 'up "direction should be set to 'up")))


    ;;test movement
    (let ((pac-move! (pacman 'move!)))
      (pac-move! 12 11)
       ((let ((new-pos (pacman 'position)))
          (check-eq? (new-pos 'x) 12 "new x should be set to 12")
          (check-eq? (new-pos 'y) 11 "new x should be set to 11"))))))
    ;;run tests
(run-test pac-man-test "pac-man ADT")

         
