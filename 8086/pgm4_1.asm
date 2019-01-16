; Rowan Kill
; CSCI 320 - Fall 2018
; 12/8/2018
; x86 Lab 1

#fasm#		  ; use intel style

ORG 100H	  ; define starting point

; display prompt
MOV AH,2	  ; display character function
MOV DL,'?'	  ; character is '?'
INT 21H           ; display char

; input a char
MOV AH,1	  ; read character function
INT 21H         ; get input character in AL
MOV BL,AL	  ; save character in BL

; go to newline
MOV AH,2	  ; display character function
MOV DL,0DH      ; 0DH is carriage return code
INT 21H         ; execute carriage return
MOV DL,0AH      ; 0AH is line feed code
INT 21H		  ; execute line feed

; display character
MOV DL,BL	  ; move char from BL (above) to DL
INT 21H		  ; display char that's now in DL

; return to DOS
MOV AH,4CH	  ; DOS exit function code
INT 21H       ; exit to DOS
