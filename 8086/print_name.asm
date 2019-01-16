; Rowan Kill
; Print the string at 0200. Load it onto the stack and print each character.

MOV AH,02
MOV BH,00
MOV SI,0200
MOV DL,[SI]   ; jump here
INT 21
INC SI
INC BH
CMP BH,0A
JNZ 0107
INT 20
