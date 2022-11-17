DosIntr      equ    21h
RetToDos     equ    4ch
Ok	     equ     0h
nutC3	     equ   9106 
nutD3	     equ
nutE3	     equ
nutF3	     equ
nutG3	     equ
nutA3	     equ
nutH3	     equ
nutC4	     equ


Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik
start:          mov     ax,dane
                mov     ds,ax
                mov     ax,stosik
                mov     ss,ax
                mov     sp,offset szczyt

		mov	ax,nutC3
		out	42h,al
		mov	al,ah		
		out	42h,al

		in 	al,61h
		or	al,00000011b
		out	61h,al

		xor	dx,dx
		mov	cx,8
		mov	ah,86h
		int	15h

		in 	al,61h
		and	al,11111100b
		out	61h,al


                mov     ah,RetToDos
		mov	al,Ok
		int	DosIntr
Progr           ends

dane            segment

dane            ends


stosik          segment
                dw    100h dup(0)
szczyt          Label word
stosik          ends


end start