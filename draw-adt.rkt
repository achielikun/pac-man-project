#lang r7rs


(define-library ()

  (import (scheme base)
          (pp1 graphics)
          (pac-man-project constants)
          (pac-man-project maze-adt))
  (export make-draw)


  (begin

    (define (make-draw width  height)
      (let ((window (make-window width  height "pac-man phase 1" 300)))
        ((window 'set-background!) "black")

        (define (draw-object! obj tile)
          (let* ((pos (obj 'position))
                 (x (pos 'x))
                 (y (pos 'y))
                 (pos-x (* x cel-width-px))
                 (pos-y (* y cel-height-px)))
            ((tile 'set-x!) pos-x)
            ((tile 'set-y!) pos-y)))

        
        (define pac-man-layer ((window 'new-layer!)))
        (define pac-man-tile #|image|#) 
        
        
        
        (define level-layer ((window 'new-layer!)))
       
        
        
        (define coin-layer ((window 'new-layer!)))
        (define coin-tile #|image|#)
        
        (define maze ((make-maze) 'maze))
        (define (make-shadow-matrix)
          (let ((shadow (make-vector game-height)))
          (do ((i 0 (+ i 1)))
              ((= i game-height))
            (let ((shadow-row (make-vector game-width))
                  (raw-row (vector-ref maze i)))
              (do ((j 0 (+ j 1)))
                  ((= j game-width))
                (let ((symbol (vector-ref raw-row j))
                      (px-x (* j cel-width-px))
                      (px-y (* i cel-height-px)))
                  
                  (cond ((eq? symbol 'x)
                         (let ((tile (make-tile cel-width-px cel-height-px)))
                           ((tile 'set-x!) px-x)
                           ((tile 'set-y!) px-y)
                           (vector-set! shadow-row j tile))))))))))


        (define (draw-maze1!)
          (do ((i 0 (+ i 1)))
              ((= i game-height))
            (let* ((raw-row (vector-ref maze i)))
              
              (do ((j 0 (+ j 1)))
                  ((= j game-width))
                (if (eq? (vector-ref raw-row i) 'x)
                    (let* ((tile (make-tile cel-width-px cel-height-px)))
                      ((tile 'draw-rectangle!) 10 10 180 80 "blue")
                      ((level-layer 'add-drawable!) tile)
                      ((tile 'set-x!) (* j cel-width-px))
                      ((tile 'set-y!) (* i cel-height-px))))))))
        
        (define (draw-maze!)
          (vector-for-each
           (lambda (row)
             (vector-for-each
              (lambda (x) ((x 'draw-rectangle! 10 10 180 80 "blue")
                         ((level-layer 'add-drawable!) x))) row))maze))
        
        
        (lambda (msg)
          (cond ((eq? msg 'start-draw!) )
                ((eq? msg 'draw-maze!) draw-maze1!)
                (else (error "draw adt -- unknown message:" msg))))))))
