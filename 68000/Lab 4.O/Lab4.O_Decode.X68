*-----------------------------------------------------------
* Title      : Lab 4.O - Hamming Decode
* Written by : Rowan Kill
* Date       : 11/3/2018
* Description: This program decodes a byte that was encoded using
*   Hamming code. The encoded value is 01010101 in binary and is
*   stored at address $2500. To decode this value, simply
*   calculate the parity of these three groups of bits: 
*   (7, 6, 5, 4), (7, 6, 3, 2), and (7, 5, 3, 1). If the parity
*   is even for the first group, then the value of check bit "R"
*   is 1. Similarly, if the parity for the second or third groups
*   are even, then the values of check bits "S" and "T" are 1,
*   respectively. If any group has an odd parity, then the value
*   of the corresponding check bit is 0. The parity is calculated
*   by XORing the values of the bits in the groups with each
*   other. For example, parityGrp1 = 7 XOR 6 XOR 5 XOR 4. In
*   order to XOR these values, they're extracted from the encoded
*   byte using the AND operation, then the registers that contain
*   the values are shifted to the right so the register holds
*   either 0 or 1 corresponding to the value of the bit. When
*   the values of the check bits are calculated, they're inserted
*   into register D0 so they can be represented at a 3-bit value
*   "RST" which will represent the position of the bit in the
*   encoded byte that contains an error. Insertion was done with
*   BFINS.
*-----------------------------------------------------------
START:                      ; first instruction of program
    LEA     $2500,A0        ; load initial address into A0
    MOVE.B  #%01010101,(A0) ; store byte to decode in A0 - 01010101b
    MOVE.B  (A0),D0         ; store initial value in D0
    
    * calculate parity of bits 7, 6, 5, 4
    * D5 contains the value of R after this block
    MOVE.B  #%01000000,D1   ; initialize D1 for 7th bit
    AND     D0,D1           ; D1 contains value of 7th bit
    LSR     #6,D1           ; shift 7th bit in D1 to 2^0 position
    MOVE.B  #%00100000,D2   ; initialize D2 for 6th bit
    AND     D0,D2           ; D2 contains value of 6th bit
    LSR     #5,D2           ; shift 6th bit in D2 to 2^0 position
    MOVE.B  #%00010000,D3   ; initialize D3 for 5th bit
    AND     D0,D3           ; D3 contains value of 5th bit
    LSR     #4,D3           ; shift 5th bit in D3 to 2^0 position
    MOVE.B  #%00001000,D4   ; initialize D4 for 4th bit
    AND     D0,D4           ; D4 contains value of 4th bit
    LSR     #3,D4           ; shift 4th bit in D4 to 2^0 position
    MOVE.B  D1,D5           ; initialize D5 to contain R
    EOR     D2,D5           ; D5 = D2 XOR D5 == 6 XOR 7
    EOR     D3,D5           ; D5 = D3 XOR D5 == 5 XOR (6 XOR 7)
    EOR     D4,D5           ; D5 = D4 XOR D5 == 4 XOR (5 XOR (6 XOR 7))
    
    * calculate parity of bits 7, 6, 3, 2
    * D6 contains the value of S after this block
    MOVE.B  #%01000000,D1   ; initialize D1 for 7th bit
    AND     D0,D1           ; D1 contains value of 7th bit
    LSR     #6,D1           ; shift 7th bit in D1 to 2^0 position
    MOVE.B  #%00100000,D2   ; initialize D2 for 6th bit
    AND     D0,D2           ; D2 contains value of 6th bit
    LSR     #5,D2           ; shift 6th bit in D2 to 2^0 position
    MOVE.B  #%00000100,D3   ; initialize D3 for 3rd bit
    AND     D0,D3           ; D3 contains value of 3rd bit
    LSR     #2,D3           ; shift 3rd bit in D3 to 2^0 position
    MOVE.B  #%00000010,D4   ; initialize D4 for 2nd bit
    AND     D0,D4           ; D4 contains value of 2nd bit
    LSR     #1,D4           ; shift 2nd bit in D4 to 2^0 position
    MOVE.B  D1,D6           ; initialize D6 to contain S
    EOR     D2,D6           ; D6 = D2 XOR D6 == 6 XOR 7
    EOR     D3,D6           ; D6 = D3 XOR D6 == 3 XOR (6 XOR 7)
    EOR     D4,D6           ; D6 = D4 XOR D6 == 2 XOR (3 XOR (6 XOR 7))
    
    * calculate parity of bits 7, 5, 3, 1
    * D7 contains the value of T after this block
    MOVE.B  #%01000000,D1   ; initialize D1 for 7th bit
    AND     D0,D1           ; D1 contains value of 7th bit
    LSR     #6,D1           ; shift 7th bit in D1 to 2^0 position
    MOVE.B  #%00010000,D2   ; initialize D2 for 5th bit
    AND     D0,D2           ; D2 contains value of 5th bit
    LSR     #4,D2           ; shift 5th bit in D2 to 2^0 position
    MOVE.B  #%00000100,D3   ; initialize D3 for 3rd bit
    AND     D0,D3           ; D3 contains value of 3rd bit
    LSR     #2,D3           ; shift 3rd bit in D3 to 2^0 position
    MOVE.B  #%00000001,D4   ; initialize D4 for 1st bit (don't shift)
    * no need to shift D4 because 1st bit already in 2^0 position
    AND     D0,D4           ; D4 contains value of 1st bit
    MOVE.B  D1,D7           ; initialize D7 to contain T
    EOR     D2,D7           ; D7 = D2 XOR D7 == 5 XOR 7
    EOR     D3,D7           ; D7 = D3 XOR D7 == 3 XOR (5 XOR 7)
    EOR     D4,D7           ; D7 = D4 XOR D7 == 1 XOR (3 XOR (5 XOR 7))
    
    * combine values of R, S, and T into one 3-bit value "RST"
    * D0 will contain "RST"
    MOVE.B  #0,D0           ; initialize D0 to contain value of RST
    BFINS   D7,D0{31:1}     ; insert value of T in 2^0 position
    BFINS   D6,D0{30:1}     ; insert value of S in 2^1 position
    BFINS   D5,D0{29:1}     ; insert value of R in 2^2 position

    SIMHALT                 ; halt simulator

    END    START            ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
