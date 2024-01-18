*-----------------------------------------------------------
* Title      : part 2
* Written by : William Geoghegan
* Date       : 18/01/2024
* Description: part 2 of practical 1
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    MOVE.L #%00001111,D1     ;Puts 00001111 in the place of D1
    MOVE.B D1,D2             ;Copy D1 to D2
    MOVE.B D1,$2000          ;copy D1 to $2000
    MOVE.B $2000,D2          ;copy $2000 to D2
    MOVE.B $2000,$3000       ;copy $2000 $3000 (3000 has the data 00001111)
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
