*-----------------------------------------------------------
* Title      : Lab 5.C
* Written by : Rowan Kill
* Date       : 10/20/2018
* Description: This program initializes a simple linked list
*    and assigns pointers to the elements in the list. After
*    that, the program initializes a new element and inserts
*    it into the existing list between elements two and three.
*-----------------------------------------------------------
    ORG    $1000
START:                      ; first instruction of program
    * Initialize addresses with data specified in figure 7.1
    MOVE.L  #$41414141, $74A8   ; move AAAA into $74A8 - data in e1
    MOVE.L  #$000074D0, $74AC   ; store address of element e2 in $74AC
    MOVE.L  #$00000000, $74B0   ; initialize area for new pointer data
    MOVE.L  #$00000000, $74B4   ; initialize area for new pointer "next"
                                ;    field
    MOVE.L  #$43434343, $74B8   ; move CCCC into $74B8 - data in e3
    MOVE.L  #$000074C0, $74BC   ; store address of element e4 in $74BC
    MOVE.L  #$44444444, $74C0   ; move DDDD into $74C0 - data in e4
                                ;    (end of list)
    MOVE.L  #$00000000, $74C4   ; store 0000 into $74C4 - would be
                                ;    address of e5
    MOVE.L  #$00000000, $74C8   ; move 00000000 into $74C8
    MOVE.L  #$00000000, $74CC   ; move 00000000 into $74CC
    MOVE.L  #$42424242, $74D0   ; move BBBB into $74D0 - e2
    MOVE.L  #$000074B8, $74D4   ; store address of e3 in $74D4
    
    * create pointers to e1 (AAAA), e2 (BBBB), and e3 (CCCC)
    LEA     $0074A8, A6     ; A6 points to e1
    MOVE.L  4(A6),A1        ; A1 points to e2, contains $74D0 because 
                            ;    the value "74D0" is at $74AE (4(A6)) 
    MOVE.L  4(A1),A2        ; A2 points to e3, $74B8, value 74B8 found at
                            ;    address $74D6, which is (4(A1))
  
    * insert a new pointer between e2 and e3
    *    load address of new pointer into A5
    *    store address of new pointer in "next" field of e2
    *    store address of e3 in "next" field of new pointer
    *    e1 -> e2 -> newPtr -> e3 -> e4
    LEA.L   $000074B0, A5   ; load new pointer address $74B0 in A5
    MOVE.L  A2, 4(A5)       ; move value 74B8 to address $74B6, stores
                            ;    the address of e3 in address $74B6
    MOVE.L  A5, 4(A1)       ; move value 74B0 to address $74D6, store
                            ;    address of new pointer in $74D6,
                            ;    overwrite previous value, which was
                            ;    the address of e3

    SIMHALT                 ; halt simulator

    END    START            ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~ 
*~Tab size~4~
