*-----------------------------------------------------------
* Title      : Lab 1.C
* Written by : Rowan Kill
* Date       : 9/1/2018
* Description: Initialize some characters and numbers, then
*    use the individual characters to spell out a message in
*    memory.
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
    LEA.L	$002200,A1  ; allocate space for result

    MOVE.B	$002016,(A1)+   ; move W to A1
    MOVE.B	$002024,(A1)+   ; move e to A1
    MOVE.B	$00202B,(A1)+   ; move l to A1
    MOVE.B	$002022,(A1)+   ; move c to A1
    MOVE.B	$00202E,(A1)+   ; move o to A1
    MOVE.B	$00202C,(A1)+   ; move m to A1
    MOVE.B	$002024,(A1)+   ; move e to A1
    MOVE.B	#32,(A1)+       ; move (space) to A1, 32 = space in base 10
    MOVE.B	19(A3) ,(A1)+   ; move t to A1 - 19th char in register A3
    MOVE.B	14(A3) ,(A1)+   ; move o to A1 - 14th char in register A3
    MOVE.B	#32,(A1)+       ; move (space) to A1
    MOVE.B	2(A2) ,(A1)+    ; move C to A1 - 2nd char in register A2
    MOVE.B	18(A2) ,(A1)+   ; move S to A1
    MOVE.B	2(A2) ,(A1)+    ; move C to A1
    MOVE.B	8(A2) ,(A1)+    ; move I to A1
    MOVE.B	#32,(A1)+       ; move (space) to A1
    MOVE.B	3(A4) ,(A1)+    ; move 3 to A1
    MOVE.B	2(A4) ,(A1)+    ; move 2 to A1
    MOVE.B	(A4) ,(A1)+     ; move 0 to A1 - 0th char in register A4 = (A4)
    MOVE.B	#33,(A1)+       ; move ! to A1
    MOVE.B	#33,(A1)+       ; move ! to A1
    MOVE.B	#33,(A1)+       ; move ! to A1
    MOVE.B	#32,(A1)+       ; move (space) to A1


    SIMHALT             ; halt simulator

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
