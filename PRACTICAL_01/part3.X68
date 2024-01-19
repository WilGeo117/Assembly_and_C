*-----------------------------------------------------------
* Title      : Part 3
* Written by : William Geoghegan
* Date       : 18/01/2024
* Description: part 3 of practical 1
*-----------------------------------------------------------
        ORG    $1000
START:                  ; first instruction of program

* Put program code here
 
     MOVE.B #$64,D1 ;moves 64 to D1
     LEA text, A1   ;Loads string text into A1
     MOVE #14,D0    ;moves 14 to D0
     TRAP #15       ;
     
     MOVE #3,D0     ;moves 3 to D0
     TRAP #15       ;
     
     SIMHALT             ; halt simulator
     
 text dc.b 'Data Register: ',0
 
 * Put variables and constants here
                         
                         ; last line of source
         END START        

No errors detected
No warnings generated


SYMBOL TABLE INFORMATION
Symbol-name         Value
-------------------------
START               1000
TEXT                101A


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~0~
