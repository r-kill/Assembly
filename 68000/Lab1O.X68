*-----------------------------------------------------------
* Title      : Lab 1.O
* Written by : Rowan Kill
* Date       : 9/22/18
* Description: This program initializes an alphabet in 
*    memory uses the characters to spell out my name and
*    a social security number in registers A1 and A5.
*-----------------------------------------------------------
    ORG    $2000
    DC.L 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    ORG    $2020
    DC.L 'abcdefghijklmnopqrstuvwxyz'
    ORG    $2040
    DC.W '0123456789'  

START:                  ; first instruction of program
    LEA.L	$002000,A2  ; load ABC... into A2
    LEA.L	$002020,A3  ; load abc... into A3
    LEA.L	$002040,A4  ; load 0123.. into A4
    LEA.L	$002100,A1  ; allocate space for name
    LEA.L   $00216B,A5  ; allocate space for SSN

    MOVE.B	17(A2),(A1)+    ; move R to A1
    MOVE.B	14(A3),(A1)+    ; move o to A1
    MOVE.B	22(A3),(A1)+    ; move w to A1
    MOVE.B	(A3),(A1)+      ; move a to A1
    MOVE.B	13(A3),(A1)+    ; move n to A1
    MOVE.B	#32,(A1)+       ; move (space) to A1
    MOVE.B	10(A2),(A1)+    ; move K to A1
    MOVE.B	8(A3),(A1)+     ; move i to A1
    MOVE.B	11(A3),(A1)+    ; move l to A1
    MOVE.B	11(A3),(A1)+    ; move l to A1
    MOVE.B  7(A4),-(A5)     ; move 7 to A5
    MOVE.B  4(A4),-(A5)     ; move 4 to A5
    MOVE.B  3(A4),-(A5)     ; move 3 to A5
    MOVE.B  2(A4),-(A5)     ; move 2 to A5
    MOVE.B  #45,-(A5)       ; move - to A5
    MOVE.B  6(A4),-(A5)     ; move 6 to A5
    MOVE.B  9(A4),-(A5)     ; move 9 to A5
    MOVE.B  #45,-(A5)       ; move - to A5
    MOVE.B  1(A4),-(A5)     ; move 1 to A5
    MOVE.B  8(A4),-(A5)     ; move 8 to A5
    MOVE.B  5(A4),-(A5)     ; move 5 to A5

    SIMHALT                 ; halt simulator

    END    START            ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
