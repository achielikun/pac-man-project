#lang r7rs


(define-library ()

  (import (scheme base)
          (pp1 graphics)
          (pac-man-project constants)
          (pac-man-project maze-adt)
          (pac-man-project coin-adt)
          (pac-man-project pac-man-adt))
  
  
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
                 (pos-y (+ score-area (* y cel-height-px))))
            ((tile 'set-x!) pos-x)
            ((tile 'set-y!) pos-y)))


      
        
        (define pac-man-layer (window 'new-layer!))
        (define pac-tile #f)
        (define pac-pos #f)
        
        
        
        
        (define level-layer (window 'new-layer!))
        (define maze ((make-maze) 'maze))
        
        (define coin-layer (window 'new-layer!))
        (define coin-tiles '())
        
   
        
        (define (draw-game!)
          (let ((maze-tile (make-tile (* game-width cel-width-px) (+ score-area (* game-height cel-height-px)))))
                
            
            (do ((i 0 (+ i 1)))
                ((= i game-height))
              (let* ((raw-row (vector-ref maze i)))
                
                (do ((j 0 (+ j 1)))
                    ((= j game-width))
                  (cond ((eq? (vector-ref raw-row j) 'x)
                         
                           
                         ((maze-tile 'draw-rectangle!)
                          (* j cel-width-px)
                          (+ score-area (* i cel-height-px))
                          (- cel-width-px distance-between-tiles) (- cel-height-px distance-between-tiles)  "blue"))
                       
                         
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
                         (set! coin-tiles (cons (cons new-coin tile) coin-tiles))))
                        ((eq? (vector-ref raw-row j) 'p)
                         (let ((tile (make-tile cel-width-px cel-height-px)))
                           ((tile 'draw-ellipse!) 2 2 (- cel-width-px 4) (- cel-height-px 4)  "yellow")
                           ((tile 'set-x!) (* j cel-width-px))
                           ((tile 'set-y!) (+ score-area (* i cel-height-px)))
                           (((pac-man-layer) 'add-drawable!) tile)
                           (set! pac-tile tile)
                           (set! pac-pos (make-pac-man j i))))))))
            (((level-layer) 'add-drawable!) maze-tile )))
          
          
          (define (sync-pacman!)
            (if (and pac-pos pac-tile)
                (draw-object! pac-pos pac-tile)))
          
          
          
        
          (lambda (msg)
            (cond ((eq? msg 'start-draw!) )
                  ((eq? msg 'sync-pacman!) sync-pacman!)
                  ((eq? msg 'get-pacman) pac-pos)
                  ((eq? msg 'draw-game!)(draw-game!))
                  ((eq? msg 'get-window) window)
                  (else (error "draw adt -- unknown message:" msg))))))))
  
