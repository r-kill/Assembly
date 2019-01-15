*-----------------------------------------------------------
* Title      : Lab 4.O - Hamming Encode
* Written by : Rowan Kill
* Date       : 10/27/2018
* Description: This program encodes four bits using Hamming code.
*   The value to encode (1011 in binary) is stored at address $2400.
*   The value is encoded by first determining the value of each bit
*   in the original nibble using the AND instruction. Next, the
*   check bits are calculated using the formulas r = a XOR b XOR c,
*   s = a XOR b XOR d, and t = a XOR c XOR d. The XOR function is
*   done using the EOR instruction. The last step involves shifting
*   the original value three bits to the left using the instruction
*   LSL, then inserting the check bits in the appropriate positions
*   using the BFINS instruction.
*-----------------------------------------------------------
START:                  ; first instruction of program
    LEA     $2400,A0    ; load initial address into A0
    MOVE.B  #%1011,(A0) ; store nibble to encode in A0 - 0b1011
    MOVE.B  (A0),D0     ; store intial value in D0
        
    * initialize data registers to hold each bit of 1011
    * the bits in 1011 are referenced as ABCD throughout this program
    MOVE.B  #%0001,D1   ; D1 will hold the rightmost bit D
    MOVE.B  #%0010,D2   ; D2 will hold the 2^1 bit C
    MOVE.B  #%0100,D3   ; D3 will hold the 2^2 bit B
    MOVE.B  #%1000,D4   ; D4 will hold the leftmost bit A
    
    * get individual bits of initial value using AND
    AND     D0,D1       ; store rightmost bit D in D1 (D1 = D0 AND D1)
    AND     D0,D2       ; store 2^1 bit C in D2       (D2 = D0 AND D2)
    AND     D0,D3       ; store 2^2 bit B in D3       (D3 = D0 AND D3)
    AND     D0,D4       ; store leftmost bit A in D4  (D4 = D0 AND D4)
    
    * initialize data registers to calculate check bits
    * check bits = r s t
    * bits to encode = A B C D
    * encoded result = A B C r D s t
    * this step makes data registes 0 or 1 to represent the 
    *    bit value in their given positions
    *    for example, D4 = 1 if A = 1 and D2 = 0 if C = 0
    * involves shifting the binary values in data registers right
    * don't shift data in D1 becauses it's already the rightmost bit
    LSR     #1,D2       ; shift 2^1 bit in D2 to 2^0 position
    LSR     #2,D3       ; shift 2^2 bit in D3 to 2^0 position
    LSR     #3,D4       ; shift leftmost bit in D4 to 2^0 position
    
    * initialize data registers to contain check bits
    *    D5 contains r
    *    D6 contains s
    *    D7 contains t
    * since every check bit uses the A bit, store that value first
    *    saves one step in XOR
    MOVE.B  D4,D5
    MOVE.B  D4,D6
    MOVE.B  D4,D7
    
    * calculate check bits r, s, and t
    *    binary value to encode: a b c d
    *    encoded binary value:   a b c r d s t
    *    r = a XOR b XOR c 
    *    s = a XOR b XOR d
    *    t = a XOR c XOR d
    * calculate r
    EOR     D3,D5   ; D5 = a XOR b == D5 XOR D3
    EOR     D2,D5   ; D5 = (a XOR b) XOR c == D5 XOR D2
    * calculate s
    EOR     D3,D6   ; D6 = a XOR b == D6 XOR D3
    EOR     D1,D6   ; D6 = (a XOR b) XOR d == D6 XOR D1
    * calculate t
    EOR     D2,D7   ; D7 = a XOR c == D7 XOR D2
    EOR     D1,D7   ; D7 = (a XOR c) XOR d == D7 XOR D1
    
    * encode original value
    *    shift ABC left 3 places and insert rDst in the open positions
    *    result will be ABCrDst
    *    first shift the value to encode 3 bit positions left
    *    then insert the check bits between the appropriate bits
    LSL     #3,D0       ; shift bits in value to encode
    BFINS   D5,D0{28:1} ; insert r between C and D
    BFINS   D1,D0{29:1} ; insert D between r and s
    BFINS   D6,D0{30:1} ; insert s between D and t
    BFINS   D7,D0{31:1} ; insert t after s, t is the last bit
    
    * store encoded result in D1
    MOVE    D0,D1

    SIMHALT             ; halt simulator

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
