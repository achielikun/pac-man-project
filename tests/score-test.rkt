#lang r7rs
(import (scheme base)
        (scheme write)
        (pp1 tests)
        (pac-man-project score-adt))

(define (score-test)
  (let ((score (make-score)))
    (check-eq? (score 'score) 0 "initial score should be 0")
              


    ((score 'score+!) 10)
    (check-eq? (score 'score) 10 "0 plus 10 should add to 10")))
(run-test score-test "score ADT")
    

               
