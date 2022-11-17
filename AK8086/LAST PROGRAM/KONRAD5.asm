DosIntr		equ    21h
RetToDos	equ    4ch
Ok			equ     0h
C			equ		023Ah
D			equ		01FBh
E			equ		01C4h
F			equ		01ABh
G			equ		017Ch
A			equ		0152h
H			equ		012Dh
p			equ 	001Eh
Cis			equ		021Ah
Dis			equ		01DFh
Eis			equ		01B7h
Fis			equ		0193h
Gis			equ		0167h
Ais			equ		013Fh
Progr       segment
            assume  cs:Progr, ds:dane, ss:stosik
start:          
            mov ax,stosik
            mov ss,ax
            mov sp,offset szczyt
			mov cx,00h    
        	mov cl,byte ptr ds:[080h]          
        	cmp cl,00h                           
        	jne argu            
bl1:		mov dx,offset blad1
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
			mov dx,si
       		mov cx,05h
			int 21h
			mov dx,00h
			mov cx,0h
			mov ax,4201h
			int 21h
			cld
			xor ax,ax
			lodsb
			cmp al,'C'
			jz nutc
			cmp al,'D'
			jz nutd
			cmp al,'E'
			jz nute
			cmp al,'F'
			jz nutf
			cmp al,'G'
			jz nutg
			cmp al,'A'
			jz nuta
			cmp al,'H'
			jz nuth
			cmp al,'c'
			jz nutcis
			cmp al,'d'
			jz nutdis
			cmp al,'e'
			jz nuteis
			cmp al,'f'
			jz nutfis
			cmp al,'g'
			jz nutgis
			cmp al,'a'
			jz nutais
			cmp al,'p'
			jz nutp
			cmp al,'0'
			jz zero
nutc:
			mov	bl,C
			call wyp
			jmp pown
nutd:
			mov	bl,D
			call wyp
			jmp pown
nute:
			mov	bl,E
			call wyp
			jmp pown
nutf:
			mov	bl,F
			call wyp
			jmp pown
nutg:
			mov	bl,G
			call wyp
			jmp pown
nuta:
			mov	bl,A
			call wyp
			jmp pown
nuth:
			mov	bl,H
			call wyp
			jmp pown
nutcis:
			mov	bl,Cis
			call wyp
			jmp pown
nutdis:
			mov	bl,Dis
			call wyp
			jmp pown
nuteis:
			mov	bl,Eis
			call wyp
			jmp pown
nutfis:
			mov	bl,Fis
			call wyp
			jmp pown
nutgis:
			mov	bl,Gis
			call wyp
			jmp pown
nutais:
			mov	bl,Ais
			call wyp
			jmp pown
nutp:
			cld
			lodsb
			mov ax,p
			jmp pown
zero:       jmp Zakoncz

pown:
			out	42h,al
			mov	al,ah		
			out	42h,al
			in 	al,61h
			or	al,00000011b
			out	61h,al
			xor	dx,dx
			xor	ax,ax
			cld
			lodsb
			cmp al,'1'
			jz nut
			cmp al,'2'
			jz pnut
			cmp al,'3'
			jz cnut
			cmp al,'4'
			jz onut
			cmp al,'5'
			jz snut
czas:				
			xor al,al
			mov dx,0ffffh
			mov	ah,86h
skok:		push cx
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

nut:
			xor cx,cx
			mov cx,10h
			jmp czas
pnut:
			xor cx,cx
			mov cx,08h
			jmp czas
cnut:
			xor cx,cx
			mov cx,04h
			jmp czas
onut:
			xor cx,cx
			mov cx,02h
			jmp czas
snut:
			xor cx,cx
			mov cx,01h
			jmp czas
Zakoncz:
            mov ah,RetToDos
			mov	al,Ok
			int	DosIntr
wyp proc
            cld
			lodsb
			sub al,30h
			cmp al,08h
			jz osma
			mov cl,al
			mov al,07h
			sub al,cl
			jz tt2
			mov cl,al
			mov ax,bx
			mov bx,02h
potenga:	
			mul bx
			loop potenga
            ret
tt2:		mov ax,bx
			ret
osma:		mov ax,bx
			mov bx,02h
			div bx
			ret
wyp endp
Progr           ends

dane            segment
blad1			db  "Nie podales argumentow",13,10,'$'
blad2			db  "Podany plik nie istnieje",13,10,'$'
nazwpli			db  50 dup(0)
muzyka 			db  5 dup(0)
dane            ends


stosik          segment stack
                dw    100h dup(0)
szczyt          Label word
stosik          ends


end start
;clk 1193180