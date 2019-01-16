*-----------------------------------------------------------
* Title      : Lab 3.C
* Written by : Rowan Kill
* Date       : 10/13/2018
* Description: This program initializes an area of memory with some
*               data that's used to examine different addressing
*               modes and instructions. This is accomplished by
*               simply moving data into registers using different
*               addressing modes, such as address register indirect
*               with index, immediate, and program counter with
*               displacement.
*-----------------------------------------------------------
    ; initialize memory - can be done with only one DC
    ORG    $2100
    DC     '44334241000000002553000001EF0000'
    DC     'FFFFCCCC87652222BBBB3333ABCDEF00'
    
START:                      ; first instruction of program
    LEA    $002100,A1       ; load location of data into A1
    MOVE.L  #10,D7          ; move A (A in hex, 10 in decimal) into D7
    MOVEQ   #27,D0          ; move 0000001B into D0, MOVEQ moves
                            ;    two bytes, similar to MOVE.L
    MOVE.B  #27,D1          ; move 1B into D1, hex(1B) == decimal(27)
    MOVE.B  #-28,D2         ; move E4 into D2, decimal(-28) ==
                            ;    hex(FFFFFFE4)    
    MOVE.W  #1001,D3        ; move 3E9 into D3, decimal(1001) == hex(3E9)
    MOVE.L  #$01010101,D4   ; move the value 01010101 into D4
    MOVE.B  16(A1,D7),D5    ; move 45 from $211A into D5
    MOVE.B  $002110(PC),D6  ; move 32 into D6, 32 is the ASCII hex 
                            ;    value for "2", found in "25530000"
                            ;    at address $2110

    SIMHALT                 ; halt simulator
    END    START            ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~ 
