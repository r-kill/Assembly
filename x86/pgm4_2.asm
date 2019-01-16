; Rowan Kill
; CSCI 320 - Fall 2018
; 12/8/2018
; x86 Lab 1

#fasm#		; use intel style

ORG	100H	; define starting point

; variables
MSG	DB	'HELLO!$'

; display msg
MOV	DX,MSG	; load MSG string into DX
MOV	AH,9	; load string display fxn
INT	21H		; execute fxn

; return to DOS
MOV	AH,4CH	; DOS exit fxn
INT 21H		; execute DOS exit fxn