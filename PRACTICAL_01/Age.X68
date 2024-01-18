*-----------------------------------------------------------
* Title      : Age in Binary
* Written by : William Geoghegan
* Date       : 18/01/2024
* Description: Shows my age (19) in binary
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    MOVE.L #%00010011,D1 
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
