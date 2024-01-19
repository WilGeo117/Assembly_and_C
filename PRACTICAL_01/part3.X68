1  *-----------------------------------------------------------
2  * Title      : Part 3
3  * Written by : William Geoghegan
4  * Date       : 18/01/2024
5  * Description: part 3 of practical 1
6  *-----------------------------------------------------------
7          ORG    $1000
8  START:                  ; first instruction of program
9  
10  * Put program code here
11  
12      MOVE.B #$64,D1 ;moves 64 to D1
13      LEA text, A1   ;
14      MOVE #14,D0    ;
15      TRAP #15       ;
16      
17      MOVE #3,D0     ;moves 3 to D0
18      TRAP #15       ;
19      
20      SIMHALT             ; halt simulator
21      
22  text dc.b 'Data Register: ',0
23  
24  * Put variables and constants here
25                          
26                          ; last line of source
27          END START        

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
