*-----------------------------------------------------------
* Title      : Lab 2.O
* Written by : Rowan Kill
* Date       : 10/6/18
* Description: This program uses PC-relative addressing for 
*               a set of instructions that reverses the
*               contents of a vector in memory. PC-relative
*               addressing mode is used to allow the program
*               to be position independent, so it can be 
*               executed from any memory address. This is
*               accomplished in two ways, the first by using
*               an offset to specify which characters to move,
*               and the other stores the first and last characters
*               of the vector in address registers that can be
*               indexed to manipulate the characters.
*-----------------------------------------------------------
     ORG    $004AC4         ; this value is either $004AC4 or $002000
                            ;    to show position independence of
                            ;    the following code.
V    DC.W   'ABCDEFGHIJ'    ; vector containing A-J
    
START:                      ; first instruction of program
    * swap A and J
    MOVE.B  (V,PC),D0       ; store A in D0 temporarily
    MOVE.B  (V+9,PC),V      ; swap J (V+9) with A
    MOVE.B  D0,V+9          ; swap A (from D0) with J

    * swap B and I
    MOVE.B  (V+1,PC),D0     ; store B in D0 temporarily
    MOVE.B  (V+8,PC),V+1    ; swap I (V+8) with B
    MOVE.B  D0,V+8          ; swap B (from D0) with I
    
    * swap C and H
    MOVE.B  (V+2,PC),D0     ; store C in D0 temporarily
    MOVE.B  (V+7,PC),V+2    ; swap H (V+7) with C
    MOVE.B  D0,V+7          ; swap C (from D0) with H
    
    * swap D and G
    MOVE.B  (V+3,PC),D0     ; store D in D0 temporarily
    MOVE.B  (V+6,PC),V+3    ; swap G (V+6) with D
    MOVE.B  D0,V+6          ; swap D (from D0) with G
    
    * swap E and F
    MOVE.B  (V+4,PC),D0     ; store E in D0 temporarily
    MOVE.B  (V+5,PC),V+4    ; swap F (V+5) with E
    MOVE.B  D0,V+5          ; swap E (from D0) with F

    SIMHALT                 ; halt simulator

    END    START            ; last line of source
    
    
*    This code produces the same result with address registers:
*    LEA.L   (V,PC),A0       ; start of vector
*    LEA.L   (V+10,PC),A1    ; end of vector (1 byte after J in vector)
*
*    * Store the first and last characters of the
*    *   vector in A0 and A1 respectively. Swap the
*    *   values at either end of the vector, working
*    *   toward the center of the vector with each
*    *   swap. The address registers are incremented
*    *   and decremented appropriately to move to
*    *   the next characters that will be swapped.
*    MOVE.B  (A0),D0         ; move A to D0
*    MOVE.B  -(A1),(A0)+     ; swap J (V+9) with A
*    MOVE.B  D0,(A1)         ; swap A (from D0) with J
* 
*    MOVE.B  (A0),D0         ; store B in D0 temporarily
*    MOVE.B  -(A1),(A0)+     ; swap I (V+8) with B
*    MOVE.B  D0,(A1)         ; swap B (from D0) with I
*    
*    MOVE.B  (A0),D0         ; store C in D0 temporarily
*    MOVE.B  -(A1),(A0)+     ; swap H (V+7) with C
*    MOVE.B  D0,(A1)         ; swap C (from D0) with H
*    
*    MOVE.B  (A0),D0         ; store D in D0 temporarily
*    MOVE.B  -(A1),(A0)+     ; swap G (V+6) with D
*    MOVE.B  D0,(A1)         ; swap D (from D0) with G
*    
*    MOVE.B  (A0),D0         ; store E in D0 temporarily
*    MOVE.B  -(A1),(A0)+     ; swap F (V+5) with E
*    MOVE.B  D0,(A1)         ; swap E (from D0) with F

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
