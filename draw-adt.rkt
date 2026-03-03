#lang r7rs


(define-library ()

  (import (scheme base)
          (pp1 graphics)
          (pac-man-project constants)
          (pac-man-project maze-adt)
          (pac-man-project coin-adt))
  
  
  (export make-draw)


  (begin

    (define (make-draw width  height)
      (let* ((window (make-window width  height "pac-man phase 1" 60)))
        ((window 'set-background!) "black")

        (define (draw-object! obj tile)
          (let* ((pos (obj 'position))
                 (x (pos 'x))
                 (y (pos 'y))
                 (pos-x (* x cel-width-px))
                 (pos-y (* y cel-height-px)))
            ((tile 'set-x!) pos-x)
            ((tile 'set-y!) pos-y)))


      
        
        (define pac-man-layer (window 'new-layer!))
        (define pac-man-tile #|image|#) 
        
        
        
        (define level-layer (window 'new-layer!))
       
        
        (define coin-layer (window 'new-layer!))

        
        (define maze ((make-maze) 'maze))
         

    
        (define coin-tiles '())
        
        (define (draw-game!)
          
          
          (do ((i 0 (+ i 1)))
              ((= i game-height))
            (let* ((raw-row (vector-ref maze i)))
              
              (do ((j 0 (+ j 1)))
                  ((= j game-width))
                (cond ((eq? (vector-ref raw-row j) 'x)
                       (let* ((tile (make-tile cel-width-px cel-height-px)))
                         
                         ((tile 'draw-rectangle!) distance-between-tiles distance-between-tiles  cel-width-px cel-height-px  "blue")
                         ((tile 'set-x!)  (* j cel-width-px))
                         ;; added plus score-area so i have a row left for the score
                         ((tile 'set-y!) (+ score-area (* i cel-height-px)))
                         (((level-layer) 'add-drawable!) tile)))
                      ((eq? (vector-ref raw-row j) '())
                       (let* ((new-coin (make-coin j i))
                              (coin-size 6)
                              (offset-x (/ (- cel-width-px coin-size) 2))
                              (offset-y (/ (- cel-height-px coin-size) 2))
                              (tile (make-tile cel-width-px cel-height-px)))
                         
                         ((tile 'draw-ellipse!) offset-x offset-y coin-size coin-size   "yellow")
                         ((tile 'set-x!)  (* j cel-width-px))
                         
                         ((tile 'set-y!) (+ score-area (* i cel-height-px)))
                         (((coin-layer) 'add-drawable!) tile)
                         (set! coin-tiles (cons (cons new-coin tile) coin-tiles)))))))))
          
          
        
        (lambda (msg)
          (cond ((eq? msg 'start-draw!) )
                ((eq? msg 'draw-game!)(draw-game!))
                (else (error "draw adt -- unknown message:" msg))))))))
