*-----------------------------------------------------------
* Title      : PRACTICAL_06
* Written by : William Geoghegan
* Date       : 27/02/2024
* Description: Part 3 of practical 6
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA $4000, A7
  
    MOVE.B  #1, -(A7)
    MOVE.B  #2, -(A7)
    MOVE.B  #3, -(A7)
    MOVE.B  #4, -(A7)
    
    MOVE.B  (A7)+, D1
    MOVE.B  (A7)+, D1
    MOVE.B  (A7)+, D1
    MOVE.B  (A7)+, D1
    SIMHALT             ; halt simulator

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
