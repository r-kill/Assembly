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
    
START:                  ; first instruction of program
    LEA    $002100,A1   ; load location of data into A1
    MOVE.L  #10,D7      ; move A (A in hex, 10 in decimal) into D7
    
*   NEW INSTRUCTION MOVEQ: according to help docs the MOVEQ (Q = quick) 
*       moves an immediate value to a data reg, the command grabs
*       2 bytes that contain the value (regardless of the value 
*       size, just grabs 2 bytes bc fast) and replaces the register 
*       value with those 2 bytes. The whole register value is 
*       altered as if MOVE.L were used because the 2 bytes just 
*       overwrite the register. So if D2 = FFFFFFFF and you 
*       MOVEQ #4,D2 then D2 will equal 00000004, if you do 
*       MOVE.B #4,D2 then D2 = FFFFFF04
    ; move 0000001B into D0, MOVEQ moves two bytes like MOVE.L
    MOVEQ   #27,D0
    MOVE.B  #27,D1      ; move 1B into D1 - hex(1B) == decimal(27)
    MOVE.B  #-28,D2     ; move E4 into D2 - decimal(-28) == hex(FFFFFFE4)    
    MOVE.W  #1001,D3    ; move 3E9 into D3 - decimal(1001) == hex(3E9)
    MOVE.L  #$01010101,D4   ; move the value 01010101 into D4
    
*   NEW INSTRUCTION: 16(A1,D7),D5
*       According to help documents within EASy68K:
*       A1+D7+16 = $2100 + 10 + 16 = $211A which stores "45" 
*       $2100 is address stored in A1
*       10 is the value stored in D7
*       16 is the offset specified, D7 acts as an additional offset
    MOVE.B  16(A1,D7),D5    ; move 45 into D5
    MOVE.B  $002110(PC),D6  ; move 32 into D6, 32 is the ASCII hex 
                            ;    value for "2," found in "25530000" at
                            ;    address $2110

    SIMHALT             ; halt simulator

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
