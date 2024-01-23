*-----------------------------------------------------------
* Title      : PRACTICAL_02
* Written by : William Geoghegan
* Date       : 23/01/2024
* Description: part 3 of practical 2
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.L  #%100,  D0
    MOVE.L  #$100,  D1
    MOVE.L  #100,   D2
    
    MOVE.L  D0, $3000
    MOVE.L  D1, $3010
    MOVE.L  D2, $3020
    
    MOVE.L  #100,   $3020
    MOVE.L  #$100,  $3010
    MOVE.L  #%100,  $3000
    
    MOVE.L  #100,   $3020
    MOVE.L  #$64,  $3010
    MOVE.L  #%10001111,  $3000

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
