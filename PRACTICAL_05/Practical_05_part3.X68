*-----------------------------------------------------------
* Title      : PRACTICAL_05
* Written by : William Geoghegan
* Date       : 13/02/2024
* Description: Part 3 of practical 5
*-----------------------------------------------------------
    ORG    $1000
DAMAGE EQU 100
START:                  ; first instruction of program
GAME_LOOP:
    LEA MSG_GAME_LOOP, A1             ; Load Game loop message to A1
    MOVE.B #13, D0                    ; Move value 13 to D0
    TRAP #15
    CMP.B #0, PLAYER_HEALTH           ; Compare players health to 0
    BEQ GAME_OVER
    BSR UPDATE
    BSR COLLISION_CHECK
    BRA GAME_LOOP
    
UPDATE:
    ADD.B #1, PLAYER_POSITION         ; Add 1 to players position
    RTS

COLLISION_CHECK:
    MOVE.B PLAYER_POSITION, D1        ; Move the player to D1
    CMP.B D2, D1                      ; Compart D2 and D1
    BEQ COLLISION
    RTS
    
COLLISION:
    SUB.B #DAMAGE, PLAYER_HEALTH     ; Remove health from player
    BRA GAME_LOOP

GAME_OVER:
    LEA MSG_GAME_OVER, A1            ; Load Game Over message to A1
    MOVE.B #13, D0
    TRAP #15
    SIMHALT            
    
PLAYER_POSITION:    DC.B 10         ; Position of the player
ENEMY_POSITION:     DC.B 50         ; Position of the enemy
PLAYER_HEALTH:      DC.B 100        ; Health of the player

MSG_GAME_LOOP       DC.B    'Game Loop........', 0
MSG_GAME_OVER       DC.B    'Game Over!', 0

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
