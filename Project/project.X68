*-----------------------------------------------------------
* Title      : START_FROM_NOTHING_PROJECT
* Written by : William Geoghegan
* Date       : 23/02/2024
* Description: An infinite loop Text based game 
*-----------------------------------------------------------
    ORG    $1000

DAMAGE     EQU    15                    ; Damage when

START:        
    MOVE    #DAMAGE,        D5                          ; first instruction of program
    BSR     HUD
    LEA     WELCOME_MSG,    A1          ; welcome message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0          ; Player Input
    TRAP    #15 
    BSR     HUD                         ; load HUD
    LEA     WELCOME_MSG_2,  A1          ; welcome message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0          ; Player Input
    TRAP    #15
    BSR     HUD                         ; load HUD
    BRA     GAME_LOOP
    
GAME_LOOP:
    BSR     HUD       
    BSR     UPDATE                      ; Call Update
    BRA     PROMPT_LOOP                 ; Call a random number for prompts
    BRA     GAME_LOOP                   ; Call GAME_LOOP
                
RANDOM_NUMBER:
    MOVE.B #8, D0                       ; Loads D1 with Time in 100's of Seconds since midnight (6 Bits)
    TRAP #15                            ; Place time in D1
    AND.L   #$5FFFFF, D1                ; AND 6 Bits to prevent any overflow
    DIVU    #100, D1                    ; Divide by 100, 1000, 10000 depending on Number range required
    SWAP    D1                          ; SWAP Higher Order Word and Lower Order Word in D1
    ADDQ.W  #1, D1                      ; Add 1 to D1.W so number is at least 1
    MOVE.W  D1, D2                      ; Extract the number from D1.W
    CLR.L   D1                          ; Clear contents of D1
    MOVE.W  D2, D1                      ; Move the generated number to D1

    RTS
                                        
PROMPT_LOOP:
    BSR RANDOM_NUMBER

    CMP.W   #5,              D2         ; Compare D2 with 1
    BLE     P1                          ; If D1 is less than 5, branch to PROMPT_1
    
    CMP.W   #10,             D2         ; Compare D2 with 2
    BLE     P2                          ; If D1 is less than 10, branch to PROMPT_2
   
    CMP.W   #15,             D2         ; Compare D2 with 3
    BLE     P3                          ; If D1 is less than 15, branch to PROMPT_3
    
    CMP.W   #20,             D2         ; Compare D2 with 4
    BLE     P4                          ; If D1 is less than 20, branch to PROMPT_4
    
    CMP.W   #25,             D2         ; Compare D2 with 5
    BLE     P5                          ; If D1 is less than 25, branch to PROMPT_5
      
    CMP.W   #30,             D2         ; Compare D2 with 6
    BLE     P6                          ; If D1 is less than 30, branch to PROMPT_6
    
    CMP.W   #35,             D2         ; Compare D2 with 7
    BLE     P7                          ; If D1 is less than 35, branch to PROMPT_7 
    
    CMP.W   #40,             D2         ; Compare D2 with 8
    BLE     P8                          ; If D1 is less than 40, branch to PROMPT_8
    
    CMP.W   #45,             D2         ; Compare D2 with 9
    BLE     P9                          ; If D1 is less than 45, branch to PROMPT_9
    
    CMP.W   #50,             D2         ; Compare D2 with 10
    BLE     P10                         ; If D1 is less than 50, branch to PROMPT_10
    
    CMP.W   #55,             D2         ; Compare D2 with 11
    BLE     P11                         ; If D1 is less than 55, branch to PROMPT_11
    
    CMP.W   #60,             D2         ; Compare D2 with 12
    BLE     P12                         ; If D1 is less than 60, branch to PROMPT_12
   
    CMP.W   #65,             D2         ; Compare D2 with 13
    BLE     P13                         ; If D1 is less than 65, branch to PROMPT_13
    
    CMP.W   #70,             D2         ; Compare D2 with 14
    BLE     P14                         ; If D1 is less than70, branch to PROMPT_14
    
    CMP.W   #75,             D2         ; Compare D2 with 15
    BLE     P15                         ; If D1 is less than 75, branch to PROMPT_15
      
    CMP.W   #80,             D2         ; Compare D2 with 16
    BLE     P16                         ; If D1 is less than 80, branch to PROMPT_16
    
    CMP.W   #85,             D2         ; Compare D2 with 17
    BLE     P17                         ; If D1 is less than 85, branch to PROMPT_17 
    
    CMP.W   #90,             D2         ; Compare D2 with 18
    BLE     P18                         ; If D1 is less than 90, branch to PROMPT_18
    
    CMP.W   #95,             D2         ; Compare D2 with 19
    BLE     P1                          ; If D1 is less than 95, branch to PROMPT_19
    
    CMP.W   #100,            D2         ; Compare D2 with 20
    BLE     P12                         ; If D1 is less than 100, branch to PROMPT_20
    
    BRA     GAME_LOOP
    
HUD:
    BSR     CLEAR_SCREEN                ; clear the screen
    LEA     MSG_HEALTH,     A1          ; load health message to A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.W  PLAYER_HEALTH,  D1          ; load player health to D1
    MOVE.B  #3,             D0
    TRAP    #15
    BSR     UPDATE
    LEA     NEW_LINE,       A1          ; load new line
    MOVE.B  #14,            D0
    TRAP    #15
    RTS
    
UPDATE:   
    CMP     #0,             PLAYER_HEALTH   ; Check if health is 0
    BLE     GAME_OVER
    RTS     


    
TEMP:
    CMP     #0,             RAT_HEALTH
    BEQ     MSG_BATTLE_OVER                 ; load Game Over message
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    BNE     RAT_COMBAT                      ; branch if not equal RAT_COMBAT
   
*--------------------------------------------------------------------------------------------------    
                                            *COMBAT*
RAT_COMBAT:
    LEA     MSG_ATTACK,     A1              ; Load attack message
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1              ; Load heal message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    
    CMP     #1,             D1              ; Compare 1 to input
    BEQ     ATTACK_RAT                      ; Branch if equal to ATTACK_RAT
    CMP     #2,             D1              ; Compare 2 to input
    BEQ     HEAL_RAT                        ; Branch if equal to HEAL_RAT
    BNE     INVALID_RAT
    
RAT_COMBAT_2:
    CMP     #0,             D4              ; Compare 0 to enemy health
    BLE     ENEMY_DEFEATED                  ; Branch to ENEMY_DEFEATED if less than
    BSR     REDUCE_HEALTH_RAT               ; Branch to directory REDUCE_HEALTH 
    BRA     RAT_COMBAT                      ; Branch to CORPSE_COMBAT
    
ATTACK_RAT:
    SUB.B   D5,             D4              ; Sub 5 from rat health
    LEA     MSG_HIT,        A1              ; Load hit messsage
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BSR     HUD                             ; Load HUD
    BRA     RAT_COMBAT_2                    ; Branch to RAT_COMBAT
    
ENEMY_COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    
    CMP     #1,             D1
    BEQ     ATTACK_ENEMY
    CMP     #2,             D1
    BEQ     HEAL_ENEMY
    BNE     INVALID_ENEMY
    
ENEMY_COMBAT_2:
    CMP     #0,             D4              ; Compare 0 to enemy health
    BLE     ENEMY_DEFEATED                  ; Branch to ENEMY_DEFEATED if less than
    BSR     REDUCE_HEALTH_ENEMY             ; Branch to directory REDUCE_HEALTH 
    BRA     ENEMY_COMBAT                    ; Branch to CORPSE_COMBAT
     
ATTACK_ENEMY:
    SUB.B   D5,             D4
    LEA     MSG_HIT,        A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BSR     HUD 
    BRA     ENEMY_COMBAT_2
    
    
MUTANT_COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    
    CMP     #1,             D1
    BEQ     ATTACK_MUTANT
    CMP     #2,             D1
    BEQ     HEAL_MUTANT
    BNE     INVALID_MUTANT
    
MUTANT_COMBAT_2:
    CMP     #0,             D4              ; Compare 0 to enemy health
    BLE     ENEMY_DEFEATED                  ; Branch to ENEMY_DEFEATED if less than
    BSR     REDUCE_HEALTH_MUTANT            ; Branch to directory REDUCE_HEALTH 
    BRA     MUTANT_COMBAT                   ; Branch to CORPSE_COMBAT
    
ATTACK_MUTANT:
    SUB.B   D5,             D4
    LEA     MSG_HIT,        A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BSR     HUD 
    BRA     MUTANT_COMBAT_2
    
PLANT_COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    
    CMP     #1,             D1
    BEQ     ATTACK_PLANT
    CMP     #2,             D1
    BEQ     HEAL_PLANT
    BNE     INVALID_PLANT
    
PLANT_COMBAT_2:
    CMP     #0,             D4              ; Compare 0 to enemy health
    BLE     ENEMY_DEFEATED                  ; Branch to ENEMY_DEFEATED if less than
    BSR     REDUCE_HEALTH_PLANT             ; Branch to directory REDUCE_HEALTH 
    BRA     PLANT_COMBAT                    ; Branch to CORPSE_COMBAT
    
ATTACK_PLANT:
    SUB.B   D5,             D4
    LEA     MSG_HIT,        A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BSR     HUD 
    BRA     PLANT_COMBAT_2
    
CORPSE_COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    
    CMP     #1,             D1
    BEQ     ATTACK_CORPSE
    CMP     #2,             D1
    BEQ     HEAL_RAT
    BNE     INVALID_CORPSE
    
CORPSE_COMBAT_2:
    CMP     #0,             D4              ; Compare 0 to enemy health
    BLE     ENEMY_DEFEATED                  ; Branch to ENEMY_DEFEATED if less than
    BSR     REDUCE_HEALTH_CORPSE            ; Branch to directory REDUCE_HEALTH 
    BRA     CORPSE_COMBAT                   ; Branch to CORPSE_COMBAT
    
ATTACK_CORPSE:
    SUB.B   D5,             D4              ; Sub damage from enemy health
    LEA     MSG_HIT,        A1              ; Load the hit message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BSR     HUD                             ; Load Hud
    BRA     CORPSE_COMBAT_2                 ; Branch to CORPSE_COMBAT_2

    
HEAL_RAT:
    ADD     #10,            PLAYER_HEALTH   ; Add 10 to players health
    LEA     MSG_HEALING,    A1              ; load healing message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH   ; compare player health to 100
    BGT     HEALTH_FIX_RAT                  ; Load HEALTH_FIX if health greater than 100
    BSR     HUD                             ; Load HUD
    BRA     RAT_COMBAT_2                    ; Load RAT_COMBAT_2

    
HEAL_ENEMY:
    ADD     #10,            PLAYER_HEALTH   ; Add 10 to player health
    LEA     MSG_HEALING,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH   ; compare player health to 100
    BGT     HEALTH_FIX_ENEMY                ; Load HEALTH_FIX if health greater than 100
    BSR     HUD                             ; Load HUD
    BRA     ENEMY_COMBAT_2                  ; Load ENEMY_COMBAT_2


HEAL_MUTANT:    
    ADD     #10,            PLAYER_HEALTH   ; Add 10 to player health
    LEA     MSG_HEALING,    A1              ; Load healing message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15                     
    CMP     #100,           PLAYER_HEALTH   ; Compart player health to 100
    BGT     HEALTH_FIX_MUTANT               ; Load HEALTH_FIX if health greater than 100
    BSR     HUD                             ; Load HUD
    BRA     MUTANT_COMBAT_2                 ; Branch to MUTANT_COMBAT_2
    
HEAL_PLANT:
    ADD     #10,            PLAYER_HEALTH   ; Add 10 to player health
    LEA     MSG_HEALING,    A1              ; Load healing message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH   ; Compart player health to 100
    BGT     HEALTH_FIX_PLANT                ; Load HEALTH_FIX if health greater than 100
    BSR     HUD                             ; Load HUD
    BRA     PLANT_COMBAT_2                  ; Branch to PLANT_COMBAT_2
    
HEAL_CORPSE:
    ADD     #10,            PLAYER_HEALTH   ; Add 10 to player health
    LEA     MSG_HEALING,    A1              ; Load helaing message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH
    BGT     HEALTH_FIX_CORPSE               ; Load HEALTH_FIX if health greater than 100
    BSR     HUD                             ; Load HUD
    BRA     CORPSE_COMBAT_2                 ; Branch to CORPSE_COMBAT_2

    
INVALID_RAT:
    LEA     MSG_INVALID,    A1              ; Load invalid messgae
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     RAT_COMBAT                      ; Branch to RAT_COMBAT
    
INVALID_ENEMY:
    LEA     MSG_INVALID,    A1              ; Load invalid messgae
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     ENEMY_COMBAT                    ; Branch to ENEMY_COMBAT
    
INVALID_MUTANT:
    LEA     MSG_INVALID,    A1              ; Load invalid messgae
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     MUTANT_COMBAT                   ; Branch to MUTANT_COMBAT
    
INVALID_PLANT:
    LEA     MSG_INVALID,    A1              ; Load invalid messgae
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     PLANT_COMBAT                    ; Branch to PLANT_COMBAT
    
INVALID_CORPSE:
    LEA     MSG_INVALID,    A1              ; Load invalid messgae
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     CORPSE_COMBAT                   ; Branch to CORPSE_COMBAT
    
ENEMY_DEFEATED:
    BSR     HUD                             ; Load HUD
    LEA     MSG_BATTLE_OVER,A1              ; Display BATTLE OVER message
    MOVE.B  #14,            D0              
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                       ; Branch to game loop
    RTS
*--------------------------------------------------------------------------------------------------
                                            *PROMPTS*
P1  
    LEA     PROMPT_1,       A1                                              *Rat
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE    RAT_HEALTH,     D4                  ; Load enemy health
    BSR     RAT_COMBAT                          ; Iitiate combat
    BRA     GAME_LOOP                           ; Branch to game loop
P2  
    LEA     PROMPT_2,       A1                                              *Rock
    MOVE.B  #14,            D0
    TRAP    #15
    SUB     #5,             PLAYER_HEALTH       ; Sub 5 from players health
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15                              
    BRA     GAME_LOOP                           ; Branch to game loop
P3  
    LEA     PROMPT_3,       A1                                              *Enemy
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE    ENEMY_HEALTH,   D4                  ; Load enemy health
    BSR     ENEMY_COMBAT                        ; Iitiate combat
    BRA     GAME_LOOP                           ; Branch to game loop
P4  
    LEA     PROMPT_4,       A1                                              *Mutant
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE    MUTANT_HEALTH,  D4                  ; Load enemy health
    BSR     MUTANT_COMBAT                       ; Iitiate combat
    BRA     GAME_LOOP                           ; Branch to game loop
P5  
    LEA     PROMPT_5,       A1                                              *Sandstorm
    MOVE.B  #14,            D0
    TRAP    #15
    SUB     #10,            PLAYER_HEALTH       ; Sub 10 from players health
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P6  
    LEA     PROMPT_6,       A1                                              *Plant
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE    PLANT_HEALTH,   D4                  ; Load enemy health
    BSR     PLANT_COMBAT                        ; Iitiate combat
    BRA     GAME_LOOP                           ; Branch to game loop
P7  
    LEA     PROMPT_7,       A1                  ; Load prompt               *Corpse
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE    CORPSE_HEALTH,     D4               ; Load enemy health
    BSR     CORPSE_COMBAT                       ; initiate combat
    BRA     GAME_LOOP                           ; Branch to game loop
P8  
    LEA     PROMPT_8,       A1                  ; Load prompt               *Spore
    MOVE.B  #14,            D0
    TRAP    #15
    SUB     #5,             PLAYER_HEALTH
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P9  
    LEA     PROMPT_9,       A1                  ; Load prompt                *Rock
    MOVE.B  #14,            D0
    TRAP    #15
    SUB     #10,            PLAYER_HEALTH
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P10  
    LEA     PROMPT_10,      A1                  ; Load prompt                *weapon
    MOVE.B  #14,            D0
    TRAP    #15
    ADD.B   #5,             DAMAGE
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop 
P11  
    LEA     PROMPT_11,      A1                  ; Load prompt                *Puddle
    MOVE.B  #14,            D0
    TRAP    #15
    ADD     #20,            PLAYER_HEALTH
    CMP     #100,           PLAYER_HEALTH
    BGT     HEALTH_FIX   
    MOVE.B  #4,             D0                  ; Player Input    
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P12  
    LEA     PROMPT_12,      A1                  ; Load prompt                 *Meat
    MOVE.B  #14,            D0
    TRAP    #15
    ADD     #5,             PLAYER_HEALTH
    CMP     #100,           PLAYER_HEALTH
    BGT     HEALTH_FIX   
    MOVE.B  #4,             D0                  ; Player Input         
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P13  
    LEA     PROMPT_13,      A1                                              *heat
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P14
    LEA     PROMPT_14,      A1                                              *Rummaging
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P15
    LEA     PROMPT_15,      A1                                              *Murder
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P16
    LEA     PROMPT_16,      A1                                              *Footsteps
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P17
    LEA     PROMPT_17,      A1                                              *Landmine
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
P18
    LEA     PROMPT_18,      A1                                              *Mutant brawl
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP                           ; Branch to game loop
*--------------------------------------------------------------------------------------------------
REDUCE_HEALTH_RAT:
    SUB     #5,                PLAYER_HEALTH    ; Sub 5 from players health
    MOVE.B  #14,               D0  
    TRAP    #15 
    BSR     HUD                                 ; Load HUD
    LEA     MSG_RAT_ATTACK,    A1               ; Load and Draw Damage Message
    MOVE.B  #14,               D0
    TRAP    #15
    RTS
    
REDUCE_HEALTH_ENEMY:
    SUB     #5,                PLAYER_HEALTH    ; Sub 5 from players health
    MOVE.B  #14,               D0  
    TRAP    #15 
    BSR     HUD                                 ; Load HUD
    LEA     MSG_ENEMY_ATTACK,  A1               ; Load and Draw Damage Message
    MOVE.B  #14,               D0
    TRAP    #15
    RTS
    
REDUCE_HEALTH_MUTANT:
    SUB     #15,               PLAYER_HEALTH    ; Sub 15 from players health
    MOVE.B  #14,               D0  
    TRAP    #15 
    BSR     HUD                                 ; Load HUD
    LEA     MSG_MUTANT_ATTACK, A1               ; Load and Draw Damage Message
    MOVE.B  #14,               D0
    TRAP    #15
    RTS
    
REDUCE_HEALTH_PLANT:
    SUB     #10,               PLAYER_HEALTH    ; Sub 10 from players health
    MOVE.B  #14,               D0  
    TRAP    #15 
    BSR     HUD                                 ; Load HUD
    LEA     MSG_PLANT_ATTACK,  A1               ; Load and Draw Damage Message
    MOVE.B  #14,               D0
    TRAP    #15
    RTS
   
REDUCE_HEALTH_CORPSE:
    SUB     #5,                PLAYER_HEALTH    ; Sub 5 from players health
    MOVE.B  #14,               D0  
    TRAP    #15 
    BSR     HUD                                 ; Load HUD
    LEA     MSG_CORPSE_ATTACK, A1               ; Load and Draw Damage Message
    MOVE.B  #14,               D0
    TRAP    #15
    RTS

HEALTH_FIX_RAT:
    MOVE.W  #100,  PLAYER_HEALTH                ; Move 100 to player health
    BRA     RAT_COMBAT_2                        ; Branch back to rat combat
    
HEALTH_FIX_ENEMY:
    MOVE.W  #100,  PLAYER_HEALTH                ; Move 100 to player health
    BRA     ENEMY_COMBAT_2                      ; Branch back to enemy combat
    
HEALTH_FIX_MUTANT:
    MOVE.W  #100,  PLAYER_HEALTH                ; Move 100 to player health
    BRA     MUTANT_COMBAT_2                     ; Branch back to mutant combat
    
HEALTH_FIX_PLANT:
    MOVE.W  #100,  PLAYER_HEALTH                ; Move 100 to player health
    BRA     PLANT_COMBAT_2                      ; Branch back to plant combat
    
HEALTH_FIX_CORPSE:
    MOVE.W  #100,  PLAYER_HEALTH                ; Move 100 to player health
    BRA     CORPSE_COMBAT_2                     ; Branch back to corpse combat
    
HEALTH_FIX:
    MOVE.W  #100,  PLAYER_HEALTH                ; Move 100 to player health
    BRA     GAME_LOOP                           ; Branch back to GAME_LOOP

CLEAR_SCREEN:
    MOVE.B  #11,               D0               ; Clear the screen
    MOVE.W  #$FF00,            D1
    TRAP    #15
    RTS
    
GAME_OVER:
    LEA     MSG_GAMEOVER,      A1               ; Load game over message
    MOVE.B  #14,               D0
    TRAP    #15
    SIMHALT

*-------------------------------------------------------------------------------------------------------|
WELCOME_MSG       DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Once-thriving cities now lay in ruins,'
                  DC.B    $0D,$0A 
                  DC.B    'their towering skyscrapers reduced to crumbling husks of steel and glass.'
                  DC.B    $0D,$0A 
                  DC.B    'Streets that had once bustled with life were now empty,'
                  DC.B    $0D,$0A 
                  DC.B    'occasional skeletal remains of vehicles and haunting echoes of a world long lost.'
                  DC.B    $0D,$0A
                  DC.B    'And in this desolate realm, that one solitary figure emerged from the sand,'
                  DC.B    $0D,$0A
                  DC.B    'a single survivor in a world on the brink of oblivion.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                
WELCOME_MSG_2     DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The shine from the sun is blinding but you pull through'
                  DC.B    $0D,$0A 
                  DC.B    'You start looking around for anything helpful to make surviving this hell'
                  DC.B    $0D,$0A 
                  DC.B    'a little more possible'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0                
*-------------------------------------------------------------------------------------------------------|
                                                *MESSAGES*
MSG_HEALTH        DC.B    'Health : ',0

MSG_ATTACK        DC.B    '1. ATTACK'
                  DC.B    $0D,$0A,0
                
MSG_HEAL          DC.B    '2. HEAL'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0

MSG_RAT_ATTACK    DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The rat leaps at you and bites your torso'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'            
                  DC.B    $0D,$0A,0  
                
MSG_ENEMY_ATTACK  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The survivor swings his knife into your side'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0  
                
MSG_MUTANT_ATTACK DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The Mutant punches you from above, crushing you into the ground'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0  
                  
MSG_PLANT_ATTACK DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The Plant flails around its long vines, hitting you'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0  
                  
MSG_CORPSE_ATTACK DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The Corpse swings its lifeless, decrepit arms at you'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0  
  
MSG_HIT           DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You attack the enemy'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0
  
MSG_HEALING       DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You wrap a bandage around your wound'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0
                
MSG_BATTLE_OVER   DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Foe has been defeated, you won the battle'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0
                
MSG_INVALID       DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Enter a valid Number.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0

MSG_GAMEOVER      DC.B    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
                  DC.B    $0D,$0A
                  DC.B    'XXXXXXXX Your vision fades to black as you drop to the sand, lifeless XXXXXXXXX'
                  DC.B    $0D,$0A
                  DC.B    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
                  DC.B    $0D,$0A
                  DC.B    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX GAME OVER XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
                  DC.B    $0D,$0A
                  DC.B    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',0
NEW_LINE          DC.B    $0D,$0A,0
*--------------------------------------------------------------------------------------------------
                                                *PROMPTS*
                                                  *BAD*
PROMPT_1          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'A mutant rat has crawled out of the ground, gnawing its teeth at you'
                  DC.B    $0D,$0A 
                  DC.B    'He looks at you as if you are his next meal, you take out your weapon'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                
PROMPT_2          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'An insane looking survivor throws a rock at you, hitting you in the head'
                  DC.B    $0D,$0A
                  DC.B    'Hes starts laughing hysterically before running off'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You take 5 Damage'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'   
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'  
                  DC.B    $0D,$0A,0    

PROMPT_3          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You see a struggling survivor that you rush to help. after grabbing'
                  DC.B    $0D,$0A
                  DC.B    'their hand they swing a knife at you, you prepare for combat'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0     
                
PROMPT_4          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The ground rumbles beneath your feet as a strong looking mutant'
                  DC.B    $0D,$0A
                  DC.B    'sprints towards your direction, prepare for a tough fight'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0 
                
PROMPT_5          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The sand begins to lift of the ground with strong gusts of wind,'
                  DC.B    $0D,$0A
                  DC.B    'you get caught up in it and chunks of scap metal fly at you'
                  DC.B    $0D,$0A 
                  DC.B    'you try to jump out of the way but you are unsuccessful'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You take 10 Damage'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'  
                  DC.B    $0D,$0A,0 
                  
PROMPT_6          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You see the ground crack underneath you and some vines pop out grabbing'
                  DC.B    $0D,$0A
                  DC.B    'at your legs, soon followed by a massive plant head with bright petals.'
                  DC.B    $0D,$0A 
                  DC.B    'It does not look too friendly, prepare for battle' 
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0 
                  
PROMPT_7          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You see a rotting corpse with flies gathered all around it in a desolate'
                  DC.B    $0D,$0A
                  DC.B    'area, The corpse suddenly starts moving towards you, it seems to have been'
                  DC.B    $0D,$0A 
                  DC.B    'taken over by parasites, you are going to have to kill it' 
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0 
                  
PROMPT_8          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'While investigating a plant you are sprayed at by its spores and put to sleep,'
                  DC.B    $0D,$0A
                  DC.B    'You wake up not knowing how long you were asleep for,'
                  DC.B    $0D,$0A 
                  DC.B    'but you dont feel good at all'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You take 5 Damage'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'  
                  DC.B    $0D,$0A,0   
                  
PROMPT_9          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'While walking you hear a *click* underneath your shoe, you are then thrown up'
                  DC.B    $0D,$0A
                  DC.B    'in the air from an explosion. you fall back on the ground in pain'
                  DC.B    $0D,$0A 
                  DC.B    'Who is planting landmines in the appocolipse!?'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You take 10 Damage'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'  
                  DC.B    $0D,$0A,0   
*--------------------------------------------------------------------------------------------------
                                                *PROMPTS*
                                                 *GOOD*
PROMPT_10         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You can see a lump in the sand and you dig up a new, better weapon'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Damage increased'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                
PROMPT_11         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You find a strange puddle and you drink the liquid out of desperation'
                  DC.B    $0D,$0A
                  DC.B    'Trying to ignore the putrid colour of the liquid'
                  DC.B    $0D,$0A
                  DC.B    'You feel a bit healthier'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Recovered 20 health'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                  
PROMPT_12         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You spot a campfire with a strange meat hanging over the fire,'
                  DC.B    $0D,$0A
                  DC.B    'Nobody is around so you decide to take it for yourself'
                  DC.B    $0D,$0A
                  DC.B    'It is not half bad but you definately dont want to know what meat this is'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Recovered 5 health'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
*--------------------------------------------------------------------------------------------------
                                                *PROMPTS*
                                                 *TEXT*
PROMPT_13         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You aimlessly walk trough the wasteland, sun burning your skin,'
                  DC.B    $0D,$0A
                  DC.B    'you can feel yourself slowly going crazy in the heat'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0                   
                                              
PROMPT_14         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You can hear the rummaging of debris in the broken down buildings,'
                  DC.B    $0D,$0A 
                  DC.B    'You know its probably best to stay out of them for now'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                  
PROMPT_15         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Screams can be heard in the distance which is shortly followed by the sound'
                  DC.B    $0D,$0A 
                  DC.B    'of a gunshot, you turn the other way and continue walking,'
                  DC.B    $0D,$0A
                  DC.B    'better him than you'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0        

PROMPT_16         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Massive footsteps can be heard heading in your direction, so you hide behind'
                  DC.B    $0D,$0A 
                  DC.B    'some wreckage, where this creature grunts while walking past you.'
                  DC.B    $0D,$0A
                  DC.B    'You do not dare look up, you get up and leave once you know its safe'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                  
PROMPT_17         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Massive footsteps can be heard heading in your direction, so you hide behind'
                  DC.B    $0D,$0A 
                  DC.B    'some wreckage, where this creature grunts while walking past you.'
                  DC.B    $0D,$0A
                  DC.B    'You do not dare look up, you get up and leave once you know its safe'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                  
PROMPT_18         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'In the distance through the sandstorms you can see two mutants having'
                  DC.B    $0D,$0A 
                  DC.B    'a brawl, they are ripping eachother appart, you do not want to fight two'
                  DC.B    $0D,$0A
                  DC.B    'mutants so you think its a bright idea to stay away'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    '                            Press Enter to continue'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0

*--------------------------------------------------------------------------------------------------
                                                *HEALTH*
PLAYER_HEALTH     DC.W    100
PLAYER_HEALTH_2   DC.W    200
HEALING           DC.W    10

RAT_HEALTH        DC.W    30
CORPSE_HEALTH     DC.W    45
ENEMY_HEALTH      DC.W    60
MUTANT_HEALTH     DC.W    60
PLANT_HEALTH      DC.W    75
*--------------------------------------------------------------------------------------------------

    END    START                    ; last line of source
    






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
