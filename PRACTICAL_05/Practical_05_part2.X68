*-----------------------------------------------------------
* Title      : PRACTICAL_05
* Written by : William Geoghegan
* Date       : 13/02/2024
* Description: Part 2 of practical 5
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    LEA PLAYER_POSITION_X, A1
    LEA ENEMY_POSITION_X, A2
    LEA PLAYER_POSITION_Y, A3
    LEA ENEMY_POSITION_Y, A4
    
    MOVE.B #50, D1
    MOVE.B #0, D2
    MOVE.L (A1)+, D1
    MOVE.L (A2)+, D2
    MOVE.L (A3)+, D3
    MOVE.L (A4)+, D4
    
COLLISION_CHECK:
    CMP D2, D1
    CMP D3, D4
    BLT NEXT_MOVE
    BEQ COLLISION
    
NEXT_MOVE:
    ADD.B #1, D2
    BRA COLLISION_CHECK
    
COLLISION:
    BRA GAME_OVER
    
GAME_OVER:
    SIMHALT            
    
PLAYER_POSITION_X: DC.B 10, 15, 55
ENEMY_POSITION_X: DC.B 15, 50, 55
PLAYER_POSITION_Y: DC.B 12, 35, 55
ENEMY_POSITION_Y: DC.B 10, 40, 55

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
