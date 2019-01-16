; Rowan Kill
; Ask the user how many times they want to print several strings, then print them.

mov ah,09
mov dx,02a0
int 21
mov ah,01
int 21
sub al,30
mov cl,al
mov ch,00
mov ah,09
mov dx,02e0
int 21
int 21
mov dx,0200
int 21
mov dx,02e0
int 21
mov dx,0220
int 21
mov dx,02e0
int 21
mov dx,0260
int 21
mov dx,02e0
int 21
int 21
loop 011a
int 20
