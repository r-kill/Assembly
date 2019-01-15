*-----------------------------------------------------------
* Title      : Lab 6.O
* Written by : Rowan Kill
* Date       : 12/1/2018
* Description: Implement a subroutine that has parameters. 
* The parameters are passed using the stack. The subroutine 
* calculates the even parity of 8, 16, or 32 bits of an input
* value.
*-----------------------------------------------------------
START:                  ; first instruction of program
    LEA.L   $2200,A1    ; initialize A1 for input
    LEA.L   $2220,A2    ; initialize A2 for size of input number
    
    * initialize arguments (input and input size)
    MOVE.L  #%1000011,(A1)              ; store input in A1 - 67 (B)
    MOVE.L  #%100000000,(A1)            ; store input - 256 (W)
    MOVE.L  #%10000000000000001,(A1)    ; store input - 65537 (L)
    MOVE.L  #1,(A2)     ; store input size in A2 - B = 1
    MOVE.L  #2,(A2)     ; store input size in A2 - W = 2
    MOVE.L  #4,(A2)     ; store input size in A2 - L = 4
    
    * move input and input size onto stack
    MOVE.L  (A1),D1     ; store input in D1
    MOVE.L  (A2),D2     ; store input side in D2
    MOVE.L  D1,-(SP)    ; push D1 onto stack (pop with (SP)+)
    MOVE.L  D2,-(SP)    ; push D2 onto stack (pop with (SP)+)
    
    * branch to function
    BRA     PARITY      ; jump to subroutine, store return address
    
    * calculate parity
    * return 1 for odd parity, 0 for even parity
    ORG     $2240
PARITY:
    MOVE.L  (SP)+,D2    ; pop size of input off of stack
    MOVE.L  (SP)+,D1    ; pop input off of stack
    
    * initialize parity bit and counter
    MOVE.L  #0,D4       ; D4 is the parity bit
    MOVE.L  #0,D5       ; D5 is the counter
    
    * store size of input temporarily and shift it left 3 places
    MOVE.L  D2,D6       ; copy size of input to a temp register
    LSL     #3,D6       ; shift D6 left 3 places
    
    LOOP:
    * get the last bit of the input number
    MOVE.L  #%0001,D7   ; use D7 to get bits from the input
    AND     D1,D7       ; get the last bit from the input
    EOR     D7,D4       ; XOR last bit of input with parity bit
    LSR.L   #1,D1       ; shift input (of any size) right once
    
    * increment counter, loop until counter == size of input
    ADD     #1,D5       ; add 1 to the counter
    CMP     D6,D5       ; compare size of input to the counter
    BNE     LOOP        ; branch to step five (getting last bit)

    SIMHALT             ; halt simulator

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
