*-----------------------------------------------------------
* Title      : PRACTICAL_03
* Written by : William Geoghegan
* Date       : 30/01/2024
* Description: part 1 of practical 3
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    LEA $4000, A1       ; Loads memory address to A2
    MOVE.B #100, (A1)   ; Moves literal 100 to A2

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
