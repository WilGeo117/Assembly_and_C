*-----------------------------------------------------------
* Title      : PRACTICAL_02
* Written by : William Geoghegan
* Date       : 23/01/2024
* Description: part 4 of practical 2
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.L  #%10,    D2      ;1
   
    MOVE.L  #12,     D3      ;2
    
    MOVE.L  #$100,   D0      ;3
    
    MOVE.B  D2,      $4000   ;4
    
    MOVE.W  A3,      $2000   ;5
    
    MOVE.L  #%1001,  D1      ;6
    
    MOVE.L  D2,      $100    ;7
    
    MOVE.W  #%1011101,    A4 ;8
    
    MOVE.W  #111,    A1      ;9
    
    MOVE.L  $800,    D2      ;10
    
    MOVE.B  #$1,     D5      ;11
    
    MOVE.L  #$80,    A6      ;12
    
    MOVE.L  #%1011,  A4      ;13
    
    MOVE.B  $5,      D3      ;14
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
