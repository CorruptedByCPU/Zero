;================================================================================
; Copyright (C) by Blackend.dev
;================================================================================

	;-----------------------------------------------------------------------
	; stałe, zmienne, globalne, struktury, obiekty itp.
	;-----------------------------------------------------------------------
	%include	"config.asm"
	;-----------------------------------------------------------------------

;===============================================================================
; ustaw "typ" kodu jądra systemu na podstawie trybu programu rozruchowego
;===============================================================================
%if STATIC_ZERO_bit_mode = 16
[BITS 16]
%endif
%if STATIC_ZERO_bit_mode = 32
[BITS 32]
%endif
%if STATIC_ZERO_bit_mode = 64
[BITS 64]
%endif

; pozycja kodu jądra systemu w przestrzeni pamięci fizycznej/logicznej
[ORG STATIC_ZERO_kernel_address << STATIC_SEGMENT_to_pointer]

kernel:
	; ustaw tylko wskaźnik docelowy na początek przestrzeni pamięci trybu tekstowego
	mov	edi,	0x000B8000

	; jeśli znajdujemy się w trybie 16 bitowym,
	%if STATIC_ZERO_bit_mode = 16
		; ustaw segment ekstra (ES) na przestrzeń pamięci trybu tekstowego
		mov	ax,	0xB800
		mov	es,	ax

		; ustaw wskaźnik docelowy na początek przestrzeni pamięci trybu tekstowego
		xor	edi,	edi
	%endif

	; kolor czcionki i tła - jasno zielony
	mov	ah,	0x0A

	; wskaźnik źródłowy na ciąg do wyświetlenia
	mov	esi,	kernel_string_welcome

.loop:
	; pobierz pierwszy znak z ciągu
	lodsb

	; wyświetl znak z ciągu na ekranie
	stosw

	; koniec ciągu?
	test	al,	al
	jnz	.loop	; nie

	; zatrzymaj dalsze wykonywanie kodu jądra
	jmp	$

;-------------------------------------------------------------------------------
kernel_string_welcome	db	"Hello, World!", 0x00
