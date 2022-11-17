NUTC equ 2331h
NUTD equ 1F31h
NUTE equ 1C31h
Prog 	segment
		assume cs:Prog,ds:dane
start: 
		mov ax,dane
		mov ds,ax
		mov si,offset muzyka
		mov ax,0
focus: 
		cld
		lodsw
		cmp al,0h
		jz Zakoncz
		mov dl,al
		xor al,al
		mov ah,02h
		int 21h
		jmp focus
Zakoncz:
		mov ah,4ch
		mov al,00h
		int 21h
Prog ends
dane segment
muzyka dw NUTC
	   dw NUTD
	   dw 0000h
	   dw NUTE
	   
dane ends
end start