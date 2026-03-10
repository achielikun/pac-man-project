#lang r7rs


(define-library ()

  (import (scheme base)
          (scheme write)
          (pp1 graphics)
          (pac-man-project constants)
          (pac-man-project maze-adt)
          (pac-man-project coin-adt)
          (pac-man-project score-adt)
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

        
        
        (define coin-layer (window 'new-layer!))
        (define coin-grid (make-vector game-height))
        
        
        
        (define pac-man-layer (window 'new-layer!))
        (define pac-tile #f)
        (define pac-pos #f)
        
        
        
        
        (define level-layer (window 'new-layer!))
        (define maze ((make-maze) 'maze))
        
        
        
        (define score (make-score))
        (define score-layer (window 'new-layer!))
        (define score-tile (make-tile window-width-px score-area))
        ((score-tile 'set-x!) 0)
        ((score-tile 'set-y!) 0)
        (((score-layer) 'add-drawable!) score-tile)


        (define pause-layer (window 'new-layer!))
        (define pause-tile (make-tile window-width-px (+ score-area window-height-px)))
        
       
        (define (toggle-pause-screen! is-paused?)
          (if is-paused?
              (begin
                ((pause-tile 'draw-rectangle!) 0 0 window-width-px (+ score-area window-height-px) "black")
                ((pause-tile 'draw-text!) "PAUSED" 40 100 100 "white")
                ((pause-tile 'draw-text!) "escape to unpause" 20 140 240 "white")     
                (((pause-layer) 'add-drawable!) pause-tile))
                (begin
                ((pause-tile 'clear!))
                (((pause-layer) 'remove-drawable!) pause-tile))))
        
        

        

        (define (refresh-score!)
          (let ((cur-val (score 'score))
                (font 18)
                (offset 50))
            (begin
              ((score-tile 'clear!))
              ((score-tile 'draw-text!) (number->string cur-val) font (- window-width-px offset) 5 "white"))))


              
   
        
        (define (draw-game!)
          ;;initialize coin grid
          (do ((k 0 (+ k 1)))
               ((= k game-height))
             (vector-set! coin-grid k (make-vector game-width #f)))
          

          ;;iniditalize wall grid
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
                           
                           ((tile 'draw-ellipse!) offset-x offset-y coin-size coin-size "yellow")
                           ((tile 'set-x!)  (* j cel-width-px))
                           
                           ((tile 'set-y!) (+ score-area (* i cel-height-px)))
                           (((coin-layer) 'add-drawable!) tile)
                           (vector-set! (vector-ref coin-grid i) j (cons new-coin tile)) ))
                        
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
          
          (define (hide-coin! x y)
            (let* ((row (vector-ref coin-grid y))
                   (pair (vector-ref row x)))
              (if (pair? pair) (let ((coin-obj (car pair))
                                     (tile-obj (cdr pair)))
                                 (begin #|(display "coins found! removing") (newline)|#
                                        (coin-obj 'eat!)
                                        ;;(((coin-layer) 'remove-drawable!) tile-obj)
                                        ((tile-obj 'clear!))
                                      ;;  ((tile-obj 'draw-ellipse!) 0 0 cel-width-px cel-height-px  "black")
                                       ;; ((tile-obj 'set-x!)  (* x cel-width-px))
                                        
                                       ;; ((tile-obj 'set-y!) (+ score-area (* y cel-height-px)))
                                        (((coin-layer) 'remove-drawable!) tile-obj)
                                        ((score 'score+!))
                                        (refresh-score!)
                                        
                                        (vector-set! row x #f))))))
      
          
        
          (lambda (msg)
            (cond ((eq? msg 'hide-coin!) hide-coin!)
                  ((eq? msg 'sync-pacman!) sync-pacman!)
                  ((eq? msg 'get-pacman) pac-pos)
                  ((eq? msg 'draw-game!)(draw-game!))
                  ((eq? msg 'get-window) window)
                  ((eq? msg 'toggle-pause-screen!) toggle-pause-screen!)
                  (else (error "draw adt -- unknown message:" msg))))))))
  
