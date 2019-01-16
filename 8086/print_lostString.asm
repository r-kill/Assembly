; Rowan Kill
; Print a long string with a symbol at the end. It is stored at memory location 0260. 
; Load the string onto the stack and print each charater.

MOV AH,02
MOV SI,0260
MOV DL,[SI] ; jump here from final JMP
CMP DL,26
JZ  0111    ; jump to the end if comparison is zero
INT 21
INC SI
JMP 0105    ; jump to DL,[SI]
INT 20
