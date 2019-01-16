; Rowan Kill
; CSCI 320 - Fall 2018
; 12/8/2018
; x86 Lab 1

#fasm#    ; use intel style

ORG 100H  ; define starting point

; strings that will be displayed
M1  DB  'ENTER A LOWER CASE LETTER: $'
M2  DB  0DH,0AH, 'IN UPPER CASE IT IS: '
C   DB  ?, '$'

; code
; print prompt
MOV DX,M1   ; get prompt
MOV AH,9    ; display string fxn
INT 21H     ; execute fxn

; input char and convert to uppercase
; conversion to uppercase is done by 
;    subtracting 20h from the input value
;    because SUB works with hex values that
;    are translated to ASCII hex codes and
;    uppercase letters are exactly 20h 
;    codes before their lowercase 
;    counterparts.
MOV AH,1    ; read char fxn
INT 21H     ; get input
SUB AL,20h  ; convert input to upper
MOV [C],AL  ; store converted input in C var

; display converted character on next line
; M2 starts output but doesn't contain the 
;    '$' character, so it overflows to 
;    include the C variable that does 
;    contain a '$.' The C variable is 
;    defined later in the program.
MOV DX,M2   ; load output
MOV AH,9    ; display string fxn
INT 21H     ; display M2

; return to DOS
MOV AH,4CH  ; DOS exit fxn
INT 21H     ; DOS exit
