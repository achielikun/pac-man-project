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
     




        (define (spawn-rgb! x y color)
          (let* ((new-coin (make-coin x y color))
                 (offset-x (/ (- cel-width-px coin-size) 2))
                 (offset-y (/ (- cel-height-px coin-size) 2))
                 (new-tile (make-tile cel-width-px cel-height-px))
                 (color (symbol->string color)))
            (begin
              ((new-tile 'draw-ellipse!) offset-x offset-y coin-size coin-size color)
              ((new-tile 'set-x!) (* x cel-width-px))
              ((new-tile 'set-y!) (+ score-area (* y cel-height-px)))
              (((coin-layer) 'add-drawable!) new-tile)

              (vector-set! (vector-ref coin-grid y) x (cons new-coin new-tile)))))


            
        (define (get-normal-coins)
          (let ((cords '()))
            (do ((y 0 (+ y 1)))
                ((= y game-height) cords)
            (let ((row (vector-ref coin-grid y)))
              (do (( x 0 (+ x 1)))
                  ((= x game-width))
                (let ((pair (vector-ref row x)))
                  (if (and (pair? pair) (eq? ((car pair) 'color) 'yellow))
                      (set! cords (cons (cons x y) cords))
                      #f)))))))
        
        (define (random-rgb!)
          (let ((yellows (get-normal-coins)))
            (if (not (null? yellows))
                (let* ((random-yellow (random (length yellows)))
                       (pick-cord (list-ref yellows random-yellow))
                       (rx (car pick-cord))
                       (ry (cdr pick-cord))
                       (old-pair (vector-ref (vector-ref coin-grid ry) rx))
                       (old-tile (cdr old-pair)))

                  (begin
                    ((old-tile 'clear!))
                    (((coin-layer) 'remove-drawable!) old-tile)

                    (let ((colors '(red green blue)))
                      (spawn-rgb! rx ry (list-ref colors (random 3)))))))))
            
        

        
     

        
        
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
              (let* ((title-font 30)
                     (sub-font 15)
                     (mid-x (/ window-width-px 2))
                     (mid-y (/ window-height-px 2)))
                
                (begin
                  ((pause-tile 'draw-rectangle!) 0 score-area window-width-px window-height-px "black")
                  ((pause-tile 'draw-text!) "Game Paused" title-font(- mid-x 100) mid-y "red")
                  ((pause-tile 'draw-text!) "escape to unpause" 20 (- mid-x 100) (+ mid-y 40) "red")     
                  (((pause-layer) 'add-drawable!) pause-tile)))
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
                        ((eq? (vector-ref raw-row j) 'u)
                         ((maze-tile 'draw-text!) "△" 20 (* j cel-width-px) (+ score-area (* i cel-height-px)) "white"))
                         
                        
                         
                        ((eq? (vector-ref raw-row j) '())
                         (let* ((new-coin (make-coin j i 'yellow))
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
            (((level-layer) 'add-drawable!) maze-tile ))
          (do ((i 0 (+ i 1)))
              ((= i colored-coins))
            (random-rgb!)))
          
          
          (define (sync-pacman!)
            (if (and pac-pos pac-tile)
                (draw-object! pac-pos pac-tile)))
          
          (define (hide-coin! x y)
            (let* ((row (vector-ref coin-grid y))
                   (pair (vector-ref row x)))
              (if (pair? pair) (let* ((coin-obj (car pair))
                                      (tile-obj (cdr pair))
                                      (color (coin-obj 'color))
                                      (val (coin-obj 'value)))
                                 (begin #|(display "coins found! removing") (newline)|#
                                        (coin-obj 'eat!)
                                        ;;(((coin-layer) 'remove-drawable!) tile-obj)
                                        ((tile-obj 'clear!))
                                      ;;  ((tile-obj 'draw-ellipse!) 0 0 cel-width-px cel-height-px  "black")
                                       ;; ((tile-obj 'set-x!)  (* x cel-width-px))
                                        
                                       ;; ((tile-obj 'set-y!) (+ score-area (* y cel-height-px)))
                                        (((coin-layer) 'remove-drawable!) tile-obj)
                                       
                                        ((score 'score+!) val)
                                        (refresh-score!)
                                        
                                        (vector-set! row x #f)

                                        (if (not (eq? color 'yellow))
                                            (random-rgb!)
                                            #f))))))
      
          
        
          (lambda (msg)
            (cond ((eq? msg 'hide-coin!) hide-coin!)
                  ((eq? msg 'sync-pacman!) sync-pacman!)
                  ((eq? msg 'get-pacman) pac-pos)
                  ((eq? msg 'draw-game!)(draw-game!))
                  ((eq? msg 'get-window) window)
                  ((eq? msg 'toggle-pause-screen!) toggle-pause-screen!)
                  (else (error "draw adt -- unknown message:" msg))))))))
  
