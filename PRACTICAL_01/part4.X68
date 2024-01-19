*-----------------------------------------------------------
* Title      : part 4
* Written by : William Geoghegan
* Date       : 18/01/2024
* Description: part 4 of practical 1
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA text, A1        ;Loads string text into A1
    MOVE #4,D0          ;moves 4 to D0
    TRAP #15            ;read a number from the keyboard
    MOVE #14,D0         ;moves 14 to D0
    TRAP #15            ;
    MOVE #3,D0          ;moves 3 to D0
    TRAP #15            ;System stops and  15
    
* Put program code here

    SIMHALT             ; halt simulator
text dc.b 'Data Register: ',
* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
