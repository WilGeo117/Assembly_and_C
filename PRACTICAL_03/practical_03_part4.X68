*-----------------------------------------------------------
* Title      : PRACTICAL_03
* Written by : William Geoghegan
* Date       : 30/01/2024
* Description: part 4 of practical 3
*-----------------------------------------------------------
    ORG    $1000
START:                      ; first instruction of program

    LEA HEALTH, A1          ; loads HEALTH to A1
    SUB.B #10, (A1)         ; subtracts 10 from A1 value
    
    LEA POINTS, A2          ; loads POINTS to A2
    SUB.B #1, (A2)          ; subtracts 1 from A2 value
    
    LEA COINS, A3           ; loads COINS to A3
    SUB.B #5, (A3)          ; subtracts 5 from A3 value
    
    LEA STORAGE_SPACE, A4   ; loads HEALTH to A4
    
    LEA ITEMS, A5           ; loads ITEMS to A5
    
    LEA DMG, A6             ; loads DMG to A6
    
    LEA SPEED, A7           ; loads DMG to A7
    
    
    LEA BOSS_HEALTH, A1     ; loads BOSS_HEALTH to B1
    
    LEA BOSS_DMG, A2        ; loads BOSS_DMG to B2
    
    LEA ENEMY_HEALTH, A3    ; loads ENEMY_HEALTH to B3
    
    LEA ENEMY_DMG, A4       ; loads ENEMY_DMG to B4
    
    LEA ENEMY_SPEED, A5     ; loads ENEMY_SPEED to B5
    
    SIMHALT                 ; halt simulator
    
*-----------------------------------------------------------
                    * PLAYER *
HEALTH dc.b $64             ; sets value of the players health
POINTS dc.l $100            ; sets value of the players points
COINS dc.b $25              ; sets value of the players coins
STORAGE_SPACE dc.l $125     ; sets value of the storage space
ITEMS dc.b $12              ; sets value of players items
DMG dc.b $15                ; sets the value of the player's damage
SPEED dc.b $20              ; sets the value of the players speed

                    * ENEMIES *
BOSS_HEALTH dc.l $250       ; sets value of the Boss' health
BOSS_DMG dc.b $30           ; sets the value of the boss' damage
ENEMY_HEALTH dc.b $20       ; sets the value of the enemy's health
ENEMY_DMG dc.b $5           ; sets the value of the enemy's damage
ENEMY_SPEED dc.b $10        ; sets the value of the enemy's speed
*-----------------------------------------------------------

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
