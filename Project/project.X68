*-----------------------------------------------------------
* Title      : PROJECT
* Written by : William Geoghegan
* Date       : 23/02/2024
* Description: An infinate Text based game 
*-----------------------------------------------------------
    ORG    $1000

DAMAGE EQU 10                           ; Damage when

START:                                  ; first instruction of program
    BSR     HUD
    LEA     WELCOME_MSG,    A1          ; welcome message
    MOVE.B  #14,            D0
    TRAP    #15
    MOVE.B  #4,             D0          ; Player Input
    TRAP    #15 
    BSR     HUD
    BRA     GAME_LOOP
    
GAME_LOOP:
        
    BSR     UPDATE                      ; Call Update
    BSR     HUD
    BSR     RANDOM_NUMBER
    BRA     GAME_LOOP                   ; Call GAME_LOOP
    
RANDOM_NUMBER:
    MOVE.B  #8,             D0          ; Command to get system time
    TRAP    #15                         ; System call to place time in D1

    AND.L   #$FFFFF,        D1          ; Optional step to limit the value, might need adjustment

                                        ; The goal is to scale the time into a 1-100 range.
                                        ; Assuming after the AND operation, we have a reasonably random value in D1,
    
    MOVEQ   #30,            D0         ; Prepare 30 in D0 for modulo operation                                                <--------- Random Number
    DIVU    D0,             D1          ; Divide D1 by 30, result in D1 (quotient) and remainder in D1's lower word
    SWAP    D1                          ; Swap to get remainder in lower word of D1
    AND.W   #$00FF,         D1          ; Ensure we only deal with the lower byte
    ADDQ.W  #1,             D1          ; Add 1 to make range 1-30 instead of 0-29

                                        ; At this point, D1 contains a random number in the 1-30 range.
    RTS                                 ; Return from subroutine
    
UPDATE:   
    CMP     #0,             D1          ; Check if health is 0
    RTS     

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
    
PROMPT_LOOP:
    BSR RANDOM_NUMBER

    CMP.W   #1,             D1          ; Compare D1 with 1
    BRA     PROMPT_1                    ; If D1 is less than 1, branch to PROMPT_1
    
    CMP.W   #2,             D1          ; Compare D1 with 2
    BRA     PROMPT_2                    ; If D1 is equal to 2, branch to PROMPT_2
    
    CMP.W   #3,             D1          ; Compare D1 with 3
    BRA     PROMPT_3                    ; If D1 is equal to 3, branch to PROMPT_3
    
    CMP.W   #4,             D1          ; Compare D1 with 4
    BRA     PROMPT_4                    ; If D1 is equal to 4, branch to PROMPT_4
    
    CMP.W   #5,             D1          ; Compare D1 with 5
    BRA     PROMPT_5                    ; If D1 is equal to 5, branch to PROMPT_5
    
    RTS
   
*--------------------------------------------------------------------------------------------------    
                                            *COMBAT*
COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    RTS 

RAT_COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    RTS
    
MUTANT_COMBAT:
    LEA     MSG_ATTACK,     A1
    MOVE.B  #14,            D0
    TRAP    #15
    LEA     MSG_HEAL,       A1
    MOVE.B  #14,            D0
    TRAP    #15
    RTS
*--------------------------------------------------------------------------------------------------
                                            *PROMPTS*
P1  
    LEA     PROMPT_1,   A1                          *Rat
    MOVE.B  #14,        D0
    TRAP    #15
    BRA     RAT_COMBAT
    RTS
P2  
    LEA     PROMPT_2,   A1                          *Rock
    MOVE.B  #14,        D0
    TRAP    #15
    SUB.B   #5,        PLAYER_HEALTH
    RTS
P3  
    LEA     PROMPT_3,   A1                          *Enemy
    MOVE.B  #14,        D0
    TRAP    #15
    BRA     COMBAT
    RTS
P4  
    LEA     PROMPT_4,   A1                          *Mutant
    MOVE.B  #14,        D0
    TRAP    #15
    BRA     MUTANT_COMBAT
    RTS
P5  
    LEA     PROMPT_5,   A1                          *Sandstorm
    MOVE.B  #14,        D0
    TRAP    #15
    SUB.B   #10,        PLAYER_HEALTH
    RTS

*--------------------------------------------------------------------------------------------------
REDUCE_HEALTH:
    SUB.B   #DAMAGE,      PLAYER_HEALTH 
    LEA     MSG_DAMAGE,   A1            ; Load and Draw Damage Message
    BRA     GAME_LOOP

CLEAR_SCREEN
    MOVE.B  #11,          D0
    MOVE.W  #$FF00,       D1
    TRAP    #15
    RTS
    
GAME_OVER:
    LEA     MSG_GAMEOVER, A1
    SIMHALT

*-------------------------------------------------------------------------------------------------------|
WELCOME_MSG     DC.B    '-----------------------------------------------------------------------------------------'
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
*-------------------------------------------------------------------------------------------------------|
                                                *PLAYER*
MSG_HEALTH      DC.B    'Health : ',0
MSG_ATTACK      DC.B    '1. ATTACK'
                DC.B    $0D,$0A,0
MSG_HEAL        DC.B    '2. HEAL'
                DC.B    $0D,$0A,0
MSG_DAMAGE      DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'Taking Damage'
                DC.B    $0D,$0A,0

MSG_GAMEOVER    DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'Your vision fades to black as you drop to the sand, lifeless'
                DC.B    $0D,$0A
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'Game Over.'
                DC.B    $0D,$0A
                DC.B    '-----------------------------------------------------------------------------------------',0
NEW_LINE        DC.B    $0D,$0A,0
*--------------------------------------------------------------------------------------------------
                                                *PROMPTS*
                                                  *BAD*
PROMPT_1        DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'A mutant rat has crawled out of the ground, you take out your weapon'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0
                
PROMPT_2        DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'An insane looking survivor throws a rock at you, hitting you in the head'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0         

PROMPT_3        DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'You see a struggling survivor that you rush to help. after grabbing'
                DC.B    $0D,$0A
                DC.B    'their hand they swing a knife at you, you prepare for combat'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0     
                
PROMPT_4        DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'The ground rumbles beneath your feet as a strong looking mutant'
                DC.B    $0D,$0A
                DC.B    'sprints towards your direction, prepare for a tough fight'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0 
                
PROMPT_5        DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'The sand begins to lift of the ground with strong gusts of wind,'
                DC.B    $0D,$0A
                DC.B    'you get caught up in it and chunks of scap metal fly at you'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0 
                                                *PROMPTS*
                                                 *GOOD*
PROMPT_21       DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'You can see a lump in the sand and you dig up a new better weapon'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0
                
PROMPT_22       DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'You find a strange puddle and you drink the liquid out of desperation'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0
                
PROMPT_23       DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A
                DC.B    'You get bored of walking around aimlessly and sharpen your weapon'
                DC.B    $0D,$0A 
                DC.B    '-----------------------------------------------------------------------------------------'
                DC.B    $0D,$0A,0

*--------------------------------------------------------------------------------------------------
                                                *HEALTH*
PLAYER_HEALTH   DC.W    100
ENEMY_HEALTH    DC.B    60
RAT_HEALTH      DC.B    25
MUTANT_HEALTH   DC.B    160
*--------------------------------------------------------------------------------------------------

    END    START                    ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
