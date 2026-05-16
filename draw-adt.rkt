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

    (#%require (only racket random))
    ;;constructor for the making of a draw object
    (define (make-draw width  height)
      ;;initialization of a window
      (let* ((window (make-window width  height "pac-man phase 1" 120)))
        ((window 'set-background!) "black")
        ;;help procedure used to draw pacman easily 
        (define (draw-object! obj tile)
          (let* ((pos (obj 'position))
                 (x (pos 'x))
                 (y (pos 'y))
                 (pos-x (exact (round (* x cel-width-px))))
                 ;;extra added to the height to ensure that the drawing doesnt overlap with the score
                 (pos-y (exact (round (+ score-area (* y cel-height-px))))))
            ((tile 'set-x!) pos-x)
            ((tile 'set-y!) pos-y)))
        
        
        ;;creation of the coin layer
        (define coin-layer (window 'new-layer!))
        (define coin-tile (make-tile (* game-width cel-width-px) (+ score-area (* game-height cel-height-px))))
        ;;creation of a coin-grid to store each coin
        (define coin-grid (make-vector game-height))
        (define total-coins 0)
     



        ;;help procedure used to create and draw a new rgb special coin
        (define (spawn-rgb! x y color)
          (let* ((new-coin (make-coin x y color))
                 
                 
                 (color (symbol->string color)))
            (begin
              ((coin-tile 'draw-ellipse!) (+ (* x cel-width-px) offset-x) (+ score-area offset-y (* y cel-height-px)) coin-size coin-size color)
             
            
            

              (vector-set! (vector-ref coin-grid y) x new-coin))))


        ;;help procedure used to get all the non rgb coins so we can select one to turn rgb when needed
        (define (get-normal-coins)
          (let ((cords '()))
            (do ((y 0 (+ y 1)))
                ((= y game-height) cords)
            (let ((row (vector-ref coin-grid y)))
              (do (( x 0 (+ x 1)))
                  ((= x game-width))
                (let ((coin (vector-ref row x)))
                  (if (and coin (eq? (coin 'color) 'yellow))
                      (set! cords (cons (cons x y) cords))
                      #f)))))))
        ;;procedure to turn a random normal coin into an rgb one this is done because we want 8 rgb coins at all time when possible.
        (define (random-rgb!)
          (let ((yellows (get-normal-coins)))
            (if (not (null? yellows))
                (let* ((random-yellow (random (length yellows)))
                       (pick-cord (list-ref yellows random-yellow))
                       (rx (car pick-cord))
                       (ry (cdr pick-cord)))
                       

                  (begin
                    ((coin-tile 'draw-ellipse!)
                                (+ offset-x (* rx cel-width-px))
                                (+ offset-y score-area (* ry cel-height-px))
                                coin-size coin-size "black")
                    
                    (let ((colors '(red green blue)))
                      (spawn-rgb! rx ry (list-ref colors (random 3)))))))))
        
        
        ;;creation of the pacman layer
        (define pac-man-layer (window 'new-layer!))
        ;;place holders for the tile and pos
        (define pac-tile #f)
        (define pac-pos #f)
        
        
        
        ;;creation of the level-layer or maze layer 
        (define level-layer (window 'new-layer!))
        ;;initialization of the maze matrix
        (define maze-object (make-maze))
        (define maze (maze-object 'maze))
          
        (define maze-tile (make-tile (* game-width cel-width-px) (+ score-area (* game-height cel-height-px))))

        (((level-layer) 'add-drawable!) maze-tile )
        (((coin-layer) 'add-drawable!) coin-tile)
            
        
        ;;initialization of the score 
        (define score (make-score))
        ;;creation of the score-layer and score tile
        (define score-layer (window 'new-layer!))
        (define score-tile (make-tile window-width-px score-area))
        ((score-tile 'set-x!) 0)
        ((score-tile 'set-y!) 0)
        (((score-layer) 'add-drawable!) score-tile)

        ;;creation of the pause layer, this is where the pause screen will be drawn
        (define pause-layer (window 'new-layer!))
        (define pause-tile (make-tile window-width-px (+ score-area window-height-px)))
        
        ;;procedure used to draw the pause screen on the screen and remove it on a toggle basis
        (define (toggle-pause-screen! is-paused?)
          (if is-paused?
              (let* ((title-font 30)
                     (sub-font 15)
                     (mid-x (/ window-width-px 2))
                     (mid-y (/ window-height-px 2)))
                
                (begin
                  ;;started at score-area so it always stays vissible
                  ((pause-tile 'draw-rectangle!) 0 score-area window-width-px window-height-px "black")
                  ((pause-tile 'draw-text!) "Game Paused" title-font (- mid-x 100) mid-y "red")
                  ((pause-tile 'draw-text!) "escape to unpause" 20 (- mid-x 100) (+ mid-y 40) "red")     
                  (((pause-layer) 'add-drawable!) pause-tile)))
                (begin
                  ((pause-tile 'clear!))
                  (((pause-layer) 'remove-drawable!) pause-tile))))
          
          

        
        ;;refreshing of the score each time the score is updated it needs to be redrawn
        (define (refresh-score!)
          (let ((cur-val (score 'score))
                (font 18)
                (offset 50))
            (begin
              ((score-tile 'clear!))
              ((score-tile 'draw-text!) (number->string cur-val) font (- window-width-px offset) 5 "white"))))


              
        ;;procedure used to draw the start of the game, the matrix and initial coins
        
        (define (draw-game!)
          (begin
            ((maze-tile 'clear!))
            ((coin-tile 'clear!))
         
            ;;initialize coin grid
            (do ((k 0 (+ k 1)))
                ((= k game-height))
              (vector-set! coin-grid k (make-vector game-width #f)))
            
            
            ;;nested do loops to loop through the matrix 
            (do ((i 0 (+ i 1)))
                ((= i game-height))
              (let* ((raw-row (vector-ref maze i)))
                
                (do ((j 0 (+ j 1)))
                    ((= j game-width))
                  (cond ((eq? (vector-ref raw-row j) 'x)
                         ;;drawing of a wall at symbol x
                         
                         
                         ((maze-tile 'draw-rectangle!)
                          (* j cel-width-px)
                          (+ score-area (* i cel-height-px))
                          (- cel-width-px distance-between-tiles) (- cel-height-px distance-between-tiles)  "blue"))
                        
                        
                        ((eq? (vector-ref raw-row j) 'u)
                         ((maze-tile 'draw-text!) "△" 20 (* j cel-width-px) (+ score-area (* i cel-height-px)) "white"))
                        
                        
                        ;;drawing and adding of a coin to the coingrid at ()
                        ((eq? (vector-ref raw-row j) '())
                         (let* ((new-coin (make-coin j i 'yellow))
                                )
                           
                           ((coin-tile 'draw-ellipse!) 
                            (+ (* j cel-width-px) offset-x )
                            
                            (+ score-area offset-y(* i cel-height-px))
                            coin-size coin-size "yellow")
                           
                           
                           (vector-set! (vector-ref coin-grid i) j new-coin ))
                         (set! total-coins (+ total-coins 1)))

                        
                        ((eq? (vector-ref raw-row j) 'p)
                         ;;drawing of the pacman tile and initialization of the pacman position
                         (let ((tile (make-tile cel-width-px cel-height-px)))
                           ((tile 'draw-ellipse!) 2 2 (- cel-width-px 4) (- cel-height-px 4)  "yellow")
                           ((tile 'set-x!) (* j cel-width-px))
                           ((tile 'set-y!) (+ score-area (* i cel-height-px)))
                           (((pac-man-layer) 'add-drawable!) tile)
                           (set! pac-tile tile)
                           (set! pac-pos (make-pac-man j i)))))))))

            
            ;; do loop to always keep the amount of rgb coins the same
            (do ((i 0 (+ i 1)))
                ((= i colored-coins))
              (random-rgb!)))
          
          ;;help procedure to sync the pacman position of on the grid and the the graphics position
          (define (sync-pac-man!)
            (if (and pac-pos pac-tile)
                (draw-object! pac-pos pac-tile)))
          ;;procedure to hide a coin when pacman eats one 
          (define (hide-coin! x y)
            (let* ((row (vector-ref coin-grid y))
                   (coin-obj (vector-ref row x)))
              (if coin-obj (let* ((color (coin-obj 'color))
                                  (val (coin-obj 'value))
                                  (pos-x (* x cel-width-px))
                                  (pos-y (+ score-area (* y cel-height-px)))
                                  )
                             (begin #|(display "coins found! removing") (newline)|#
                               (coin-obj 'eat!)
                               
                               ((coin-tile 'draw-ellipse!)
                                (+ offset-x pos-x)
                                (+ offset-y pos-y)
                                coin-size coin-size "black")
                               
                              
                               ;;updating the score when a coin is eaten 
                               ((score 'score+!) val)
                               (refresh-score!)                              
                               (vector-set! row x #f)
                              
                               (set! total-coins (- total-coins 1))

                               (if (= total-coins 0)
                                   (begin (next-level!) (display "next level")))
                               
                               ;; if it wasnt a yellow coin that was removed to add another random rgb coin
                               (if (not (eq? color 'yellow))
                                   (random-rgb!)
                                   #f))))))



       (define (next-level!)
          (begin
            (maze-object 'next-level!)
            (set! maze (maze-object 'maze))
            (draw-game!)))
      
      ;;dispatch lambda used to create object closure 
      (lambda (msg)
        (cond ((eq? msg 'hide-coin!) hide-coin!) 
              ((eq? msg 'sync-pac-man!) sync-pac-man!)
              ((eq? msg 'get-pac-man) pac-pos) ;;getter for the pacman object
              ((eq? msg 'get-maze) maze-object)
              ((eq? msg 'draw-game!)(draw-game!))
              ((eq? msg 'get-window) window) ;;getter for the window 
              ((eq? msg 'toggle-pause-screen!) toggle-pause-screen!)
              (else (error "draw adt -- unknown message:" msg))))))))


