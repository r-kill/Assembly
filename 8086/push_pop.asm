; Rowan Kill
; Print a string to the terminal and use the push and pop instructions.

MOV   BX,C00F
PUSH  BX
MOV   BX,EF1E
PUSH  BX
MOV   BX,3124
PUSH  BX
MOV   BX,4123
PUSH  BX
POP   AX
POP   BX
ADD   AX,BX
MOV   [0200],AX
POP   BX
ADD   AX,BX
MOV   [0202],AX
POP   BX
ADD   AX,BX
MOV   [0204],AX
MOV   CL,24
MOV   [0206],CL
MOV   AH,09
MOV   DX,0200
INT   21
INT   20
