Prog        segment
            assume 	cs:Prog, ds:dane
start:     
			mov     ax,dane
            mov     ds,ax
            call    ent
			xor     dh,dh
            mov 	dl,offset zach
            mov 	ah,09h
            int 	21h
            mov 	dx,offset max
            mov 	ah,0ah
            int		21h
            mov 	cl,len
            xor 	bh,bh 
            mov 	bl,00h
sprw:
            xor 	ah,ah
            mov 	al,znaki[bx]
			inc     bl
            cmp 	al,40h
            ja 		blad
            cmp 	al,29h
            jb 		blad
            loop 	sprw
			mov 	cl,len
            xor 	bh,bh 
            mov 	bl,00h
			jmp 	dod
blad:      
			call    ent
			xor     dh,dh
            mov 	dl,offset bla
            mov 	ah,09h
            int 	21h
            jmp 	koniec
blad2:      
			call    ent
			xor     dh,dh
            mov 	dl,offset bla2
            mov 	ah,09h
            int 	21h
            jmp 	koniec
dod:
            mov 	dx,0Ah
            mov 	ax,suma
            mul 	dx
            jc 		blad2
            mov 	suma,ax
            xor	 	dh,dh
            mov 	dl,znaki[bx]
            sub 	dx,30h
            mov 	ax,suma
            add 	ax,dx
            mov 	suma,ax
            jc 		blad2
            inc 	bl
            loop 	dod
dal:
            call    ent
			xor     dh,dh
			mov 	dl,offset lad3
            mov 	ah,09h
            int 	21h
            xor 	bh,bh 
            mov 	bl,len
            mov 	znaki[bx],'$'
            mov 	ah,09h
            mov		dx,offset znaki
            int		21h
            call    ent
			xor     dh,dh
			mov		dl,offset lad1
            mov 	ah,09h
            int 	21h
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
			xor     dh,dh
			mov 	dl,offset lad2
            mov 	ah,09h
            int 	21h
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
Prog        	ends
dane            segment
max             db  6h
len             db  ?
znaki           db  6h dup(0h)
suma            dw  0h
hex             db  '0123456789ABCDEF'
zach            db  'Podaj liczbe 5 cyfrowa:$'
bla             db  'Podana wartosc to nie liczba$'
bla2            db  'Liczba jest spoza zakresu.$'
lad1			db  'Liczba w systemie 2:  $'
lad2			db  'Liczba w systemie 16: $'
lad3			db	'Liczba w systemie 10: $'
dane            ends
end start