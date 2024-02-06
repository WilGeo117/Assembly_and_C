*-----------------------------------------------------------
* Title      : PRACTICAL_04
* Written by : William Geoghegan
* Date       : 06/02/2024
* Description: part 1 of practical 4
*-----------------------------------------------------------
    ORG    $1000
START:                 

    MOVE.B  #100, $3000   ; Move Health to memory location $3000

    LEA     $3000, A1     ; Load Memory address $3000 into A1
    
    SUB.B   #20, (A1)     ; Hit by NPC
    ADD.B   #10, (A1)     ; pick up health

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
