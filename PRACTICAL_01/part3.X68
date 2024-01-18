00001000 Starting Address
Assembler used: EASy68K Editor/Assembler v5.16.01
Created On: 18/01/2024 14:40:45

00000000                             1  *-----------------------------------------------------------
00000000                             2  * Title      : Part 3
00000000                             3  * Written by : William Geoghegan
00000000                             4  * Date       : 18/01/2024
00000000                             5  * Description: part 3 of practical 1
00000000                             6  *-----------------------------------------------------------
00001000                             7          ORG    $1000
00001000                             8  START:                  ; first instruction of program
00001000                             9  
00001000                            10  * Put program code here
00001000                            11  
00001000  123C 0064                 12      MOVE.B #$64,D1 ;moves 64 to D1
00001004  43F9 0000101A             13      LEA text, A1   ;
0000100A  303C 000E                 14      MOVE #14,D0    ;
0000100E  4E4F                      15      TRAP #15       ;
00001010                            16      
00001010  303C 0003                 17      MOVE #3,D0     ;moves 3 to D0
00001014  4E4F                      18      TRAP #15       ;
00001016                            19      
00001016  FFFF FFFF                 20      SIMHALT             ; halt simulator
0000101A                            21      
0000101A= 44 61 74 61 20 52 ...     22  text dc.b 'Data Register: ',0
0000102A                            23  
0000102A                            24  * Put variables and constants here
0000102A                            25                          
0000102A                            26                          ; last line of source
0000102A                            27          END START        

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
