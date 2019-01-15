*-----------------------------------------------------------
* Title      : Lab 2.C
* Written by : Rowan Kill
* Date       : 9/29/2018
* Description: This lab was designed to make use of the
*    different addressing modes and become more familiar
*    with register use and working with memory. The main
*    goal is to trace the program and analyze the changes
*    in the various registers used during execution.
*-----------------------------------------------------------
START:                          ; first instruction of program
*   initialize registers
    LEA.L   $002468FA,A3        ; load 002468FA into A3
    LEA.L   $00002544,A4        ; load 00002544 into A4
    LEA.L   $00002518,A6        ; load 00002518 into A6
    
*   move specified values into memory
    MOVE.L  #$44334241, $2518   ; move 44334241 into $2518
    MOVE.L  #$00000000, $251C   ; move 00000000 into $251C
    MOVE.L  #$25530000, $2520   ; move 25530000 into $2520
    MOVE.L  #$01EFABCD, $2524   ; move 01EFABCD into $2524
    MOVE.L  #$5476CC22, $2528   ; move 5476CC22 into $2528
    MOVE.L  #$FF3412FF, $252C   ; move FF3412FF into $252C
    MOVE.L  #$A2671FEE, $2544   ; move A2671FEE into $2544
    MOVE.L  #$FFFFFFFF, $2548   ; move FFFFFFFF into $2548
    MOVE.L  #$01000000, $254C   ; move 01000000 into $254C
    MOVE.L  #$ABCDFFFF, $2550   ; move ABCDFFFF into $2550
    MOVE.L  #$00000000, $2554   ; move 00000000 into $2554
    
*   initialize data registers
    MOVE.B $00000000, D3        ; move $00000000 into D3 (content of $00000000)
    MOVE.B $FFFFFFFF, D5        ; move $FFFFFFFF into D5
    MOVE.B $00000000, D6        ; I noticed these use MOVE.B on the
                                ;   code worksheet, may need MOVE.L
                                ;   and the '#$' notation to replicate
                                ;   Lab 2.C worksheet.

*   change register values
    MOVE.B  3(A6),D3            ; move 'A' into D3
    MOVE.W  4(A4),6(A6)         ; move FF into $251E
    MOVE.L  (A6)+,D5            ; move 'D' into D5, increment A6 to $2519
    MOVE.W  (A4)+,$2522         ; move A2 into $2522, increment A4 to $2545
    MOVE.B  $252E,-(A4)         ; move 12 into $2544 (pre-decrement A4 to $2544)
    LEA.L   $252A,A3            ; load $252A into A3 (CC22FF34)
    MOVE.W  (A3),D6             ; move CC22 into D6

    SIMHALT                     ; halt simulator
    END    START                ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
