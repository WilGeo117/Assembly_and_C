*-----------------------------------------------------------
* Title      : START_FROM_NOTHING_PROJECT
* Written by : William Geoghegan
* Date       : 23/02/2024
* Description: An infinate loop Text based game 
*-----------------------------------------------------------
    ORG    $1000

DAMAGE     EQU    15                 ; Damage when

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
                
RANDOM_NUMBER:                          ; The goal is to scale the time into a 1-100 range.
                                        ; Assuming after the AND operation, we have a reasonably random value in D1,
    MOVEQ   #8,             D0          ; Prepare 8 in D0 for modulo operation                                                <--------- Random Number
    DIVU    D0,             D2          ; Divide D1 by 8, result in D1 (quotient) and remainder in D1's lower word
    SWAP    D2                          ; Swap to get remainder in lower word of D1
    AND.W   #$00FF,         D2          ; Ensure we only deal with the lower byte
    ADDQ.W  #1,             D2          ; Add 1 to make range 1-8 instead of 0-7

                                        ; At this point, D1 contains a random number in the 1-5 range.
    RTS                                 ; Return from subroutine
                                        
PROMPT_LOOP:
    BSR RANDOM_NUMBER

    CMP.W   #1,             D2          ; Compare D1 with 1
    BEQ     P1                          ; If D1 is less than 1, branch to PROMPT_1
    
    CMP.W   #2,             D2          ; Compare D1 with 2
    BEQ     P2                          ; If D1 is equal to 2, branch to PROMPT_2
   
    CMP.W   #3,             D2          ; Compare D1 with 3
    BEQ     P3                          ; If D1 is equal to 3, branch to PROMPT_3
    
    CMP.W   #4,             D2          ; Compare D1 with 4
    BEQ     P4                          ; If D1 is equal to 4, branch to PROMPT_4
    
    CMP.W   #5,             D2          ; Compare D1 with 5
    BEQ     P5                          ; If D1 is equal to 5, branch to PROMPT_5
      
    CMP.W   #6,             D2          ; Compare D1 with 6
    BEQ     P6                          ; If D1 is equal to 6, branch to PROMPT_6
    
    CMP.W   #7,             D2          ; Compare D1 with 7
    BEQ     P7                          ; If D1 is equal to 7, branch to PROMPT_7 
    
    CMP.W   #8,             D2          ; Compare D1 with 8
    BEQ     P8                          ; If D1 is equal to 8, branch to PROMPT_8
    
    BRA     GAME_LOOP
    
HUD:
    BSR     CLEAR_SCREEN 
    LEA     MSG_HEALTH,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.W  PLAYER_HEALTH,  D1
    MOVE.B  #3,             D0
    TRAP    #15
    LEA     NEW_LINE,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    RTS
    
UPDATE:   
    CMP     #0,         PLAYER_HEALTH       ; Check if health is 0
    BEQ     GAME_OVER
    RTS     


    
TEMP:
    CMP     #0,         RAT_HEALTH
    BEQ     MSG_BATTLE_OVER
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BNE     RAT_COMBAT
   
*--------------------------------------------------------------------------------------------------    
                                            *COMBAT*
RAT_COMBAT:
    MOVE    RAT_HEALTH,     D4
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    
    CMP     #1,             D1
    BEQ     ATTACK_RAT
    CMP     #2,             D1
    BEQ     HEAL_RAT
    BNE     INVALID_RAT
    
RAT_COMBAT_2
    CMP     #0,             D4
    BLE     ENEMY_DEFEATED
    BSR     REDUCE_HEALTH_RAT
    BRA     RAT_COMBAT
    
ATTACK_RAT:
    SUB.B   D5,             D4
    LEA     MSG_HIT,        A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BSR     HUD 
    BRA     RAT_COMBAT_2
    
ENEMY_COMBAT:                                                       * D4 ENEMY HEALTH LOCATION
    MOVE    ENEMY_HEALTH,   D4
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
    CMP     #0,             ENEMY_HEALTH
    BEQ     ENEMY_DEFEATED
    BSR     REDUCE_HEALTH_ENEMY
    BRA     ENEMY_COMBAT
    
ATTACK_ENEMY:
    SUB.B   #DAMAGE,        D4
    LEA     MSG_HIT,        A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    RTS
    
    
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
    CMP     #0,             MUTANT_HEALTH
    BEQ     ENEMY_DEFEATED
    BSR     REDUCE_HEALTH_MUTANT
    BRA     MUTANT_COMBAT
    RTS
    
ATTACK_MUTANT: 
    SUB.B   #DAMAGE,        MUTANT_HEALTH
    LEA     MSG_HIT,        A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    RTS
    
HEAL_RAT:
    ADD     #10,            PLAYER_HEALTH
    LEA     MSG_HEALING,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH
    BGT     HEALTH_FIX
    BRA     RAT_COMBAT_2
    
HEAL_ENEMY:
    ADD     #10,            PLAYER_HEALTH
    LEA     MSG_HEALING,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH
    BGT     HEALTH_FIX
    BRA     ENEMY_COMBAT


HEAL_MUTANT:
    ADD     #10,            PLAYER_HEALTH
    LEA     MSG_HEALING,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15 
    CMP     #100,           PLAYER_HEALTH
    BGT     HEALTH_FIX
    BRA     MUTANT_COMBAT

    
    
INVALID_RAT
    LEA     MSG_INVALID,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     RAT_COMBAT
    
INVALID_ENEMY
    LEA     MSG_INVALID,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     ENEMY_COMBAT
    
INVALID_MUTANT
    LEA     MSG_INVALID,    A1
    MOVE.B  #14,            D0
    TRAP    #15
    BRA     MUTANT_COMBAT
    
ENEMY_DEFEATED
    LEA     MSG_BATTLE_OVER,A1
    MOVE.B  #4,             D0              ; Player Input
    TRAP    #15
    BRA     GAME_LOOP
    RTS
*--------------------------------------------------------------------------------------------------
                                            *PROMPTS*
P1  
    LEA     PROMPT_1,   A1                                  *Rat
    MOVE.B  #14,        D0
    TRAP    #15
    BSR     RAT_COMBAT
    BRA     GAME_LOOP
    
P2  
    LEA     PROMPT_2,   A1                                  *Rock
    MOVE.B  #14,        D0
    TRAP    #15
    SUB     #5,         PLAYER_HEALTH
    MOVE.B  #4,         D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP
P3  
    LEA     PROMPT_3,   A1                                  *Enemy
    MOVE.B  #14,        D0
    TRAP    #15
    BSR     ENEMY_COMBAT
    BRA     GAME_LOOP
P4  
    LEA     PROMPT_4,   A1                                  *Mutant
    MOVE.B  #14,        D0
    TRAP    #15
    BSR     MUTANT_COMBAT
    BRA     GAME_LOOP
P5  
    LEA     PROMPT_5,   A1                                  *Sandstorm
    MOVE.B  #14,        D0
    TRAP    #15
    SUB     #10,        PLAYER_HEALTH
    MOVE.B  #4,         D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP
    
P6  
    LEA     PROMPT_6,   A1                                  *heat
    MOVE.B  #14,        D0
    TRAP    #15
    MOVE.B  #4,         D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP
    
P7  
    LEA     PROMPT_7,   A1                                  *weapon
    MOVE.B  #14,        D0
    TRAP    #15
    ADD.B   #5,         DAMAGE
    MOVE.B  #4,         D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP
    
P8  
    LEA     PROMPT_8,   A1                                  *Puddle
    MOVE.B  #14,        D0
    TRAP    #15
    ADD     #20,        PLAYER_HEALTH
    CMP     #100,       PLAYER_HEALTH
    BGT     HEALTH_FIX   
    MOVE.B  #4,         D0                  ; Player Input
    TRAP    #15
    BRA     GAME_LOOP
    
P9


P10

*--------------------------------------------------------------------------------------------------
REDUCE_HEALTH_RAT:
    SUB.B   #5,               PLAYER_HEALTH 
    LEA     MSG_RAT_ATTACK,   A1               ; Load and Draw Damage Message
    MOVE.B  #14,              D0
    TRAP    #15
    RTS
    
REDUCE_HEALTH_ENEMY:
    SUB.B   #5,                 PLAYER_HEALTH 
    LEA     MSG_ENEMY_ATTACK,   A1             ; Load and Draw Damage Message
    MOVE.B  #14,                D0
    TRAP    #15
    RTS
    
REDUCE_HEALTH_MUTANT:
    SUB.B   #10,                PLAYER_HEALTH 
    LEA     MSG_MUTANT_ATTACK,  A1            ; Load and Draw Damage Message
    MOVE.B  #14,                D0
    TRAP    #15
    RTS
    
HEALTH_FIX:
    MOVE.W    #100,  PLAYER_HEALTH
    BRA       GAME_LOOP

CLEAR_SCREEN:
    MOVE.B  #11,          D0
    MOVE.W  #$FF00,       D1
    TRAP    #15
    RTS
    
GAME_OVER:
    LEA     MSG_GAMEOVER, A1
    MOVE.B  #14,          D0
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
                  DC.B    'Press Enter to Start.'
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
                  DC.B    'Press Enter to Start.'
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
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0  
                
MSG_ENEMY_ATTACK  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The survivor swings his knife into your side'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.' 
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0  
                
MSG_MUTANT_ATTACK DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'The Mutant punches you from above, crushing you into the ground'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
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
                  DC.B    'Press Enter to continue.'
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
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'  
                  DC.B    $0D,$0A,0 
                
PROMPT_6          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You aimlessly walk trough the wasteland, sun burning your skin,'
                  DC.B    $0D,$0A
                  DC.B    'you can feel yourself slowly going crazy in the heat'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'              
                  DC.B    $0D,$0A,0
*--------------------------------------------------------------------------------------------------
                                                *PROMPTS*
                                                 *GOOD*
PROMPT_7          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'You can see a lump in the sand and you dig up a new, better weapon'
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Damage increased'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                
PROMPT_8          DC.B    '-----------------------------------------------------------------------------------------'
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
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                  
PROMPT_9          DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    ' '
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    ' '
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
                  
PROMPT_10         DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    ' '
                  DC.B    $0D,$0A 
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    ' '
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A
                  DC.B    'Press Enter to continue.'
                  DC.B    $0D,$0A
                  DC.B    '-----------------------------------------------------------------------------------------'
                  DC.B    $0D,$0A,0
*--------------------------------------------------------------------------------------------------
                                                *HEALTH*
PLAYER_HEALTH     DC.W    100
HEALING           DC.W    10
ENEMY_HEALTH      DC.W    60
RAT_HEALTH        DC.W    20
MUTANT_HEALTH     DC.W    120
*--------------------------------------------------------------------------------------------------

    END    START                    ; last line of source
    

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
