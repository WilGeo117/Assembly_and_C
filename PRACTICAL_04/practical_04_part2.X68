*-----------------------------------------------------------
* Title      : PRACTICAL_04
* Written by : William Geoghegan
* Date       : 06/02/2024
* Description: part 2 of practical 4
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

    MOVE.B #100, $3000
    MOVE.B #12, D2      ; Move location of player
    MOVE.B #$22, D3
    
    AND.B D2, D3        ; D1 and D2, result in D2             ; 1/1 = 1,  0/1 = 0, 0/0 = 0
    
    LEA $3000, A1
    
    SUB.B #20, (A1)
    ADD.B #10, (A1)

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
