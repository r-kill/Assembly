; Rowan Kill
; CSCI 320 - Fall 2018
; 12/8/2018
; x86 Lab 1

#fasm#		; use intel style

ORG	100H	; define offset for variables

; data
PRE	DB	'THE SUM OF $'
MID	DB	' AND $'
SUF DB  ' IS $'

; display prompt
MOV	AH,2	; display character function
MOV	DL,'?'	; character is '?'
INT	21H		; display char

; input two chars
MOV	AH,1	; read character function
INT	21H		; get input character in AL
MOV	BL,AL	; save character in BL
MOV	AH,1	; read character function
INT	21H		; get input character in AL
MOV	CL,AL	; save character in CL

; go to newline
MOV	AH,2	; display character function
MOV	DL,0DH	; 0DH is carriage return code
INT	21H		; execute carriage return
MOV	DL,0AH	; 0AH is line feed code
INT 21H		; execute line feed

; display output
; display "THE SUM OF "
MOV	DX,PRE	; load PRE string into DX
MOV	AH,9	; display string function
INT 21H		; display PRE string

; display first input
MOV AH,2	; display character function
MOV	DL,BL	; move char from BL (above) to DL
INT 21H		; display char that's now in DL

; display " AND "
MOV	DX,MID	; load PRE string into DX
MOV	AH,9	; display string function
INT 21H		; display MID string

; display second input
MOV AH,2	; char display fxn
MOV	DL,CL	; move char from CL (above) to DL
INT 21H		; display char that's now in DL

; display " IS "
MOV	DX,SUF	; load PRE string into DX
MOV	AH,9	; display string function
INT 21H		; display SUF string

; display sum
; must subtract 30h from the sum in BL because
;    the ADD instruction will add the hex values
;    of the operands, so if 2 and 7 are input,
;    the sum will be 32h + 37h = 69h == 'i'
;    subtracting 30h ensures result is within 
;    the range of ASCII hex codes for the values 
;    0 - 9.
; note that this subtraction method ONLY works
;    because the instructions specify t hat the
;    sum is to be less than ten.
ADD	BL,CL	; add CL to BL, store sum in BL
SUB	BL,30h	; subtract 30h from sum
MOV	AH,2	; display string fxn
MOV	DL,BL	; move sum in BL to DL
INT	21H		; print the sum

; return to DOS
MOV AH,4CH	; DOS exit function code
INT	21H		; exit to DOS