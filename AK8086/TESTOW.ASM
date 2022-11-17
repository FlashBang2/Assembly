zakoncz equ  21h
Prog        segment
            assume 	cs:Prog, ds:dane
start:		
			mov ax,dane
			mov ds,ax
			mov si,offset znaki
			mov cl,10
loopx:
			mov dl,[si]
			add dl,30h
			mov ah,2h
			int zakoncz
			inc si
			loop loopx
			mov ah,4ch
			mov al,0h
			int zakoncz
Prog		ends
dane 		segment
znaki 		db  6h dup(1h)
dane 		ends
end start 