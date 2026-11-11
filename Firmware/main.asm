
; 80C31 TRAFFIC LIGHT CONTROLLER
; ASEM-51 / Proteus 8 / 12 MHz
;
; ROAD SIGNALS: ACTIVE HIGH
; P1.0 = NORTH-SOUTH RED
; P1.1 = NORTH-SOUTH YELLOW
; P1.2 = NORTH-SOUTH GREEN
; P1.3 = EAST-WEST RED
; P1.4 = EAST-WEST YELLOW
; P1.5 = EAST-WEST GREEN
;
; PEDESTRIAN LEDs: ACTIVE LOW
; P1.6 = WALK
; P1.7 = DON'T WALK
;
; Automatic pedestrian phase.
; No pedestrian button required yet.

ORG 0000H
    LJMP START

ORG 0030H

START:
    MOV SP,#060H

    ; TIMER 0 - MODE 1 (16 BIT)
    MOV TMOD,#01H
    CLR TR0
    CLR TF0

    ; INITIAL ALL-RED PHASE
    MOV P1,#049H
    MOV R4,#02H
    LCALL WAIT_SECONDS

MAIN_LOOP:

    ; -------------------------
    ; NORTH-SOUTH GREEN
    ; EAST-WEST RED
    ; -------------------------

    MOV P1,#04CH
    MOV R4,#05H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; NORTH-SOUTH YELLOW
    ; EAST-WEST RED
    ; -------------------------

    MOV P1,#04AH
    MOV R4,#02H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; BOTH DIRECTIONS RED
    ; -------------------------

    MOV P1,#049H
    MOV R4,#01H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; NORTH-SOUTH RED
    ; EAST-WEST GREEN
    ; -------------------------

    MOV P1,#061H
    MOV R4,#05H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; NORTH-SOUTH RED
    ; EAST-WEST YELLOW
    ; -------------------------

    MOV P1,#051H
    MOV R4,#03H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; BOTH DIRECTIONS RED
    ; -------------------------

    MOV P1,#049H
    MOV R4,#01H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; PEDESTRIAN WALK
    ; BOTH ROAD SIGNALS RED
    ; -------------------------

    MOV P1,#089H
    MOV R4,#04H
    LCALL WAIT_SECONDS

    ; -------------------------
    ; PEDESTRIAN STOP
    ; BOTH ROAD SIGNALS RED
    ; -------------------------

    MOV P1,#049H
    MOV R4,#02H
    LCALL WAIT_SECONDS

    LJMP MAIN_LOOP


; ============================
; SECOND-BASED DELAY
; ============================

WAIT_SECONDS:
    MOV R5,#014H

SEC_TICK:
    LCALL WAIT_50MS

    DJNZ R5,SEC_TICK
    DJNZ R4,WAIT_SECONDS

    RET


; ============================
; TIMER 0 APPROX. 50 MS
; ============================

WAIT_50MS:

    CLR TR0
    CLR TF0

    MOV TH0,#03CH
    MOV TL0,#0B0H

    SETB TR0

TIMER_WAIT:
    JNB TF0,TIMER_WAIT

    CLR TR0
    CLR TF0

    RET

END
