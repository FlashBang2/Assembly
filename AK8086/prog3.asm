Prog        segment
            assume 	cs:Prog, ds:dane, ss:stosik
start:     
			mov     ax,dane
            mov     ds,ax
            mov     ax,stosik
            mov     ss,ax
            mov     sp,offset szczyt
            call    ent
            mov 	dl,offset zach
            call    wyp
            mov 	dx,offset max
            mov 	ah,0ah
            int		21h
            mov 	cl,len
            xor 	bh,bh 
            mov 	bl,00h
sprw:
            xor 	ah,ah
            mov 	al,znaki[bx]
            inc 	bl
            cmp 	al,39h
            ja 		blad
            cmp 	al,30h
            jb 		blad
            loop 	sprw
			mov 	cl,len
            xor 	bh,bh 
            mov 	bl,00h
			jmp 	dod
blad:      
			call    ent
            mov 	dl,offset bla
            call    wyp
            jmp 	koniec
blad2:      
			call    ent
            mov 	dl,offset bla2
            call    wyp
            jmp 	koniec
dod:
            mov 	dx,0Ah
            mov 	ax,suma
            mul 	dx
            jc 		blad2
            mov 	suma,ax
            xor	 	dh,dh
            mov 	dl,znaki[bx]
            sub 	dx,'0'
            mov 	ax,suma
            add 	ax,dx
            mov 	suma,ax
            jc 		blad2
            inc 	bl
            loop 	dod
dal:
            call    ent
			mov 	dl,offset lad3
            call    wyp
            xor 	bh,bh 
            mov 	bl,len
            mov 	znaki[bx],'$'
            mov		dx,offset znaki
            call    wyp
            call    ent
			mov		dl,offset lad1
            call    wyp
            mov 	ah,2h
            mov 	bx,suma
            mov 	cx,10h
kolejb:     
			mov 	dl,'0'
            rcl 	bx,1h 
            jnc 	omin
            inc 	dl
omin:       
			int 	21h
            loop	kolejb
            call    ent
			mov 	dl,offset lad2
            call    wyp
            mov 	ah,2h
            mov 	bx,suma
            mov 	cx,4h
kolejh:     
			mov 	si,000Fh
            rol 	bx,4h
            and 	si,bx
            mov 	dl,hex[si]
            int 	21h
            loop 	kolejh
koniec:
            mov		ah,4ch
	        mov		al,0h
	        int		21h
ent proc
            mov 	dx,0Ah
            mov 	ah,2h
            int 	21h  
            mov 	dx,0Dh
            mov 	ah,2h
            int 	21h
            ret
ent endp
wyp proc
            mov 	ah,09h
            int 	21h
            ret
wyp endp
Prog        ends

dane            segment
max             db  6h
len             db  ?
znaki           db  6h dup(0h)
suma            dw  0h
hex             db  '0123456789ABCDEF'
zach            db  'Podaj liczbe 5 cyfrowa:$'
bla             db  'Podana wartosc to nie liczba$'
bla2            db  'Liczba jest za duza.$'
lad1			db  'Liczba w systemie 2:  $'
lad2			db  'Liczba w systemie 16: $'
lad3			db	'Liczba w systemie 10: $'
dane            ends

stosik          segment stack
                dw    100h dup(0h)
szczyt          Label word
stosik          ends

end start