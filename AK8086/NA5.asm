DosIntr     equ    21h
RetToDos    equ    4ch
Ok	     	equ     0h
pausix  	equ  001Eh
NUTC1		equ	 8D3Ch
NUTD1		equ  7DF8h
NUTE1		equ  71ADh
NUTF1		equ  69EDh
NUTG1		equ  5F1Eh
NUTA1		equ  54BEh
NUTH1		equ  4B2Ch
NUTC2		equ	 47B4h
NUTD2		equ	 3FD8h
NUTE2		equ	 38D6h
NUTF2		equ  3592h
NUTG2		equ  2F8Fh
NUTA2 		equ	 2A5Fh
NUTH2		equ	 25E4h
NUTC3		equ	 2394h
NUTD3		equ	 1FB4h
NUTE3		equ	 1C3Fh
NUTF3		equ	 1AA2h
NUTG3		equ	 17C7h
NUTA3		equ  152Fh
NUTH3		equ	 12DEh
NUTC4		equ  11CAh
NUTD4		equ  0FDAh
NUTE4		equ  0E1Fh
NUTF4		equ	 0D5Ah
NUTG4		equ  0BE3h
NUTA4		equ  0A97h
NUTH4		equ  096Fh
NUTC5		equ  08E9h
NUTD5		equ  07F0h
NUTE5		equ  0712h
NUTF5		equ  06ADh
NUTG5		equ  05F1h
NUTA5		equ  054Bh
NUTH5		equ  04B7h
NUTC6		equ  0473h
NUTD6		equ  03F7h
NUTE6		equ  0388h
NUTF6		equ  0356h
NUTG6		equ  02F8h
NUTA6		equ  02A5h
NUTH6		equ  025Bh
NUTC7		equ  023Ah
NUTD7		equ  01FBh
NUTE7		equ  01C4h
NUTF7		equ  01ABh
NUTG7		equ  017Ch
NUTA7		equ  0152h
NUTH7		equ  012Dh
NUTC8		equ  011Dh
NUTCIS1		equ	 852Ah
NUTDIS1		equ	 7782h
NUTEIS1		equ  6EF9h
NUTFIS1		equ	 6552h
NUTGIS1		equ	 59A1h
NUTAIS1		equ  505Ch
NUTCIS2		equ	 438Ch
NUTDIS2		equ	 3C87h
NUTEIS2		equ  377Ch
NUTFIS2		equ	 32A9h
NUTGIS2		equ	 2CD0h
NUTAIS2		equ  282Eh
NUTCIS3		equ	 2188h
NUTDIS3		equ	 1DE0h
NUTEIS3		equ  1B6Ah
NUTFIS3		equ	 1931h
NUTGIS3		equ	 1668h
NUTAIS3		equ  1400h
NUTCIS4		equ	 10D3h
NUTDIS4		equ	 0EFCh
NUTEIS4		equ  0DBFh
NUTFIS4		equ	 0C98h
NUTGIS4		equ	 0B3Bh
NUTAIS4		equ  0A00h
NUTCIS5		equ  0869h
NUTDIS5		equ	 077Eh
NUTEIS5		equ  06DFh
NUTFIS5		equ	 064Ch
NUTGIS5		equ	 059Bh
NUTAIS5		equ  0501h
NUTCIS6		equ  0433h
NUTDIS6		equ	 03BEh
NUTEIS6		equ  036Fh
NUTFIS6		equ	 0326h
NUTGIS6		equ	 02CEh
NUTAIS6		equ  027Fh
NUTCIS7		equ  021Ah
NUTDIS7		equ	 01DFh
NUTEIS7		equ  01B7h
NUTFIS7		equ	 0193h
NUTGIS7		equ	 0167h
NUTAIS7		equ  013Fh
KonM 		equ  0000h

Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik
start:          mov     ax,dane
                mov     ds,ax
                mov     ax,stosik
                mov     ss,ax
                mov     sp,offset szczyt
				mov     si,offset muzyka
				
tas:
				cld
				lodsw
				cmp al,0h
				jz Zakoncz
				out	42h,al
				mov	al,ah		
				out	42h,al
				in 	al,61h
				or	al,00000011b
				out	61h,al
				xor	dx,dx
				lodsw
				mov	cx,ax
				xor al,al
				mov	ah,86h
				int	15h
				in 	al,61h
				and	al,11111100b
				out	61h,al
				xor ax,ax
				xor cx,cx
				jmp tas
Zakoncz:
                mov ah,RetToDos
				mov	al,Ok
				int	DosIntr
				
Progr           ends

dane            segment
muzyka			dw NUTC3,0010h
				dw NUTD3,0010h
				dw NUTE3,0008h
				dw NUTF3,0008h
				dw NUTG3,0008h
				dw NUTA3,0008h
			    dw NUTH3,0010h
				dw pausix,0010h
				dw NUTC4,0008h
				dw NUTH3,0008h
				dw NUTA3,0008h
				dw NUTG3,0008h
				dw NUTF3,0008h
				dw NUTE3,0008h
				dw NUTD3,0008h
				dw NUTC3,0008h
				dw KonM
dane            ends


stosik          segment
                dw    100h dup(0)
szczyt          Label word
stosik          ends


end start