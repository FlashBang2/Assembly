DosIntr     equ    21h
RetToDos    equ    4ch
Ok	     	equ     0h
Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik
start:          
                mov ax,stosik
                mov ss,ax
                mov sp,offset szczyt
				mov cx,00h    
        		mov cl,byte ptr ds:[080h]          
        		cmp cl,00h                            
        		jne argu            
bl1:			mov dx,offset blad1
        		mov ax,dane
        		mov ds,ax
        		mov ah,09h
        		int 21h
				jmp Zakoncz
bladotw:
				mov dx, offset blad2
				mov ah,09h
				int 21h
				jmp Zakoncz
argu:
				mov si,082h                         
        		mov ax,seg nazwpli
        		mov es,ax
        		mov di,offset nazwpli         
        		mov bl,0Dh
nazwa:
				cmp cl,00h                            
       		 	je konnazw                
       			mov al,byte ptr ds:[si]
        		cmp al,bl                           
        		je konnazw    
				mov bl,' '
				cmp al,bl                           
        		je bl1
				mov bl,0Dh
wczyt:
            	mov byte ptr es:[di],al         
            	inc si
            	inc di
            	dec cl                          
            	jmp nazwa
konnazw:
				mov ax,seg nazwpli	
    		    mov ds,ax
    		    mov dx,offset nazwpli	
    		    mov cx,0
    		    mov ax,0                            
    		    mov ah,3dh                          
    		    int 21h
				jc bladotw
				mov bx,ax
				mov ax,dane
				mov ds,ax
				mov ax,00h
tas:
				push bx
				mov si,offset muzyka
				mov ah,3fh
				mov dx,offset muzyka
       			mov cx,08h
				int 21h
				mov dx,00h
				mov cx,0h
				mov ax,4201h
				int 21h
				cld
				lodsw
				cmp al,3Ah
				ja 	diffrence	
				sub al,30h
temp1:			cmp ah,3Ah
				ja diffrence2
				sub ah,30h				
temp2:			rol al,04h
				add al,ah
				xor ah,ah
				push ax
				
				cld
				lodsw
				cmp al,3Ah
				ja diffrence3
				sub al,30h
temp3:			cmp ah,3Ah
				ja diffrence4
				sub ah,30h
temp4:			rol al,04h
				add al,ah
				pop bx
				mov ah,bl
				cmp ax,00h
				jz Zakoncz
				out	42h,al
				mov	al,ah		
				out	42h,al
				in 	al,61h
				or	al,00000011b
				out	61h,al
				xor	dx,dx
				cld
				lodsw
				sub al,30h
				sub ah,30h
				cmp al,00h
				ja diffrence5
				mov al,ah
				xor ah,ah
temp5:			mov	cx,ax
				xor al,al
				mov	ah,86h
				mov dx,0ffffh
skok:			push cx
				xor cx,cx
				int	15h
				pop cx
				loop skok
				in 	al,61h
				and	al,11111100b
				out	61h,al
				xor ax,ax
				xor cx,cx
				cld
				lodsw
				pop bx
				jmp tas
diffrence:		sub al,37h
				jmp temp1
diffrence2:		sub ah,37h
				jmp temp2
diffrence3:		sub al,37h
				jmp temp3
diffrence4:		sub ah,37h
				jmp temp4
Zakoncz:
                mov ah,RetToDos
				mov	al,Ok
				int	DosIntr
diffrence5: 	rol al,04h
				jmp temp5
Progr           ends

dane            segment
blad1			db  "Nie podales argumentow",13,10,'$'
blad2			db  "Podany plik nie istnieje",13,10,'$'
nazwpli			db  50 dup(0)
muzyka 			dw  4 dup(0)
dane            ends


stosik          segment stack
                dw    100h dup(0)
szczyt          Label word
stosik          ends


end start