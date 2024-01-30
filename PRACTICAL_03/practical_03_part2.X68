*-----------------------------------------------------------
* Title      : PRACTICAL_03
* Written by : William Geoghegan
* Date       : 30/01/2024
* Description: part 2 of practical 3
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA $4000, A2       ; Loads memory address to A2
    MOVE.B #100, (A2)   ; Moves literal 100 to A2
    SUB.B #10, (A2)     ; Subtract literal 10 from A2

    SIMHALT             ; halt simulator

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
