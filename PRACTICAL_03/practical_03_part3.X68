*-----------------------------------------------------------
* Title      : PRACTICAL_03
* Written by : William Geoghegan
* Date       : 30/01/2024
* Description: Part 3 of practical 3
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    LEA HEALTH, A3      ; loads HEALTH to A3
    SUB.B #10, (A3)     ; subtracts 10 from A3 value

    SIMHALT             ; halt simulator

HEALTH dc.b $64         ; sets value of players health
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
