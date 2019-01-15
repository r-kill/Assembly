*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
* Leanred commands: BSR, RTS; if loop is used, then include ROL, CMP, BNE
* TODO: Still need to figure out what instructions mean by having D4 not change value
*-----------------------------------------------------------
START:                      ; first instruction of program
    LEA     $2200,A1        ; initialize A1 for result
    LEA     $0021F0,A0      ; initialize memory for value A59BD2FC
    MOVE.L  #$A59BD2FC,(A0) ; store initial value at address $2100
    
    * unsure if I should keep these ????????????????????????????????????????????
    MOVE.L  (A0),D4 ; store initial value in D4 - shouldn't change
    MOVE.L  #0,D7   ; counter for loop
    

    * call subroutine to separate value in A0
    BSR     GET_NIBBLES     ; jump to subroutine, store return addr
* have to call subroutine 4 times if loop is not used (once per byte)
*    use this in conjunction with the commented out body of the loop (not the uncommented version)   
*    BSR     GET_NIBBLES     ; jump to subroutine, store return addr
*    BSR     GET_NIBBLES     ; jump to subroutine, store return addr
*    BSR     GET_NIBBLES     ; jump to subroutine, store return addr
    
    
    
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

*    can use this method for separating the nibbles WITHOUT A LOOP !!!!!!!!!!!!!!!!!!!
*        doesn't use shifting as often, which kind of defeats the purpose of the lab
*    MOVE.B  (A0)+,D0        ; move a byte ("9B") from A0 to D0, A0++
*    MOVE.B  D0,D1           ; move value in D0 to D1, create a copy
*    AND     #%11110000,D0   ; get the first nibble of the byte ("9")
*    MOVE.B  D0,(A1)+        ; move the nibble to address $2200, A1++
*    
*    AND     #%00001111,D1   ; get the second nibble of the byte ("B")
*    LSL     #4,D1           ; shift the nibble to left-justify byte
*    MOVE.B  D1,(A1)+        ; move the nibble to address (A1)+
*    RTS                     ; return to main routine START

    SIMHALT                 ; halt simulator

    END    START            ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
