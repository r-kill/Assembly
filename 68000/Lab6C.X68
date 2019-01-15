*-----------------------------------------------------------
* Title      : Lab 6.C
* Written by : Rowan Kill
* Date       : 11/10/2018
* Description: This program uses shifting and logical operations
*    to separate each nibble in a given hexadecimal value. The
*    data register containing the value to be separated is supposed
*    to appear as it does initially after the program finishes
*    execution, which emphasizes the use of shifting and rotation.
*    This program also uses a subroutine with a loop to accomplish
*    this task as a way to practice for the upcoming lab 6.O, 
*    although these aren't required.
*-----------------------------------------------------------
START:                      ; first instruction of program
    LEA     $2200,A1        ; initialize A1 for result
    LEA     $0021F0,A0      ; initialize memory for value A59BD2FC
    MOVE.L  #$A59BD2FC,(A0) ; store initial value at address $2100
    MOVE.L  (A0),D4         ; store initial value in D4
    MOVE.L  #0,D7           ; counter for loop

    * call subroutine to separate value in A0
    BSR     GET_NIBBLES     ; jump to subroutine, store return addr
    
    
    * separate each nibble of 8-byte value in A0 in subroutine below
    ORG $002210
GET_NIBBLES:
    ROL.L   #4,D4           ; rotate leftmost nibble to 2^0 position
    MOVE.B  D4,D5           ; store rightmost byte from D4 in D5
    AND     #%1111,D5       ; get rightmost nibble of the byte in D5
    LSL     #4,D5           ; shift the nibble to left-justify byte
    MOVE.B  D5,(A1)+        ; store new byte at address (A1) - $2200
    ADD     #1,D7           ; increment counter - used to exit loop
    CMP     #8,D7           ; ensure counter < max iteration count
    BNE     GET_NIBBLES     ; loop if count < max iteration count
    RTS                     ; return to main routine START

    SIMHALT                 ; halt simulator

    END    START            ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
