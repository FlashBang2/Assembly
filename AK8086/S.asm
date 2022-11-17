Prog 	segment
		assume cs:Prog,ds:dane
start:	
		mov ax,dane
		mov ds,ax
		xor ax,ax 		 
        mov es,ax 		  
        xor bx,bx		
	    mov bl,es:[046ch]
        mov al,los[bx]
		mov dl,10
		mul dl
		push ax
		mov cx,80
		cld
		push ds
        push ds
        pop  es
		mov ah,0B8h
		mov ds,ax
		mov di,offset bufor
		mov si,0
		rep movsw
		pop ds
		mov cx,80
		cld
		mov es,ax
		mov ah,30h
		xor di,di
		mov al," "
		rep stosw
		mov cx,16
		mov ah,86h 
        mov dx,0ffffh
skok:   push cx
        xor cx,cx    
	    int 15h       
        pop  cx         
	    loop skok
		mov cx,80
		cld
		pop ax
		mov ah,0B8h
		mov es,ax
		mov di,0
		mov si,offset bufor
		rep movsw
		xor al,al
		mov ah,01h
		int 16h
		jz start
		mov ah,4ch
		mov al,0h
		int 21h
		
Prog ends
dane segment
bufor db 160 dup(?)
los	 db 13, 15, 20, 9, 17, 9, 21, 0, 0, 20, 9, 7, 11, 0, 5, 14, 0, 19, 16, 9, 2, 6, 23, 18, 19, 24, 1, 8, 3, 10, 23, 22, 2, 13, 6, 12, 20, 24, 24, 6, 3, 18, 6, 12, 17, 0, 1, 23, 22, 8, 3, 3, 20, 23, 12, 4, 22, 10, 3, 12, 24, 3, 1, 22, 15, 15, 11, 3, 5, 21, 22, 7, 22, 20, 3, 22, 5, 3, 7, 19, 10, 18, 5, 19, 15, 18, 24, 16, 6, 15, 18, 13, 24, 12, 3, 23, 20, 1, 21, 17, 7, 14, 6, 24, 15, 22, 6, 15, 6, 8, 11, 20, 12, 4, 1, 1, 3, 12, 22, 14, 13, 13, 22, 6, 15, 19, 5, 21, 12, 2, 0, 12, 8, 9, 9, 22, 4, 7, 12, 21, 12, 21, 7, 3, 13, 14, 0, 21, 10, 16, 13, 0, 12, 16, 9, 16, 9, 9, 17, 14, 8, 17, 4, 13, 22, 3, 23, 11, 23, 13, 18, 3, 11, 16, 6, 19, 13, 20, 10, 15, 17, 1, 21, 3, 11, 0, 2, 18, 8, 6, 8, 21, 20, 11, 7, 23, 20, 2, 11, 2, 2, 3, 21, 12, 18, 2, 0, 15, 4, 1, 20, 3, 8, 23, 13, 21, 15, 18, 22, 10, 15, 5, 10, 15, 23, 21, 16, 5, 13, 9, 5, 1, 0, 15, 0, 21, 3, 16, 23, 15, 14, 9, 2, 15, 10, 17, 19, 6, 19, 13, 10, 19, 8, 13, 9, 1
dane ends
end start