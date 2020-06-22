;===============================================================================
; Copyright (C) by vLock.dev
;===============================================================================

;===============================================================================
zero_storage:
	; inicjalizuj dostępne nośniki
	call	driver_ide_init

	; wczytaj plik jądra systemu
	mov	eax,	((zero_end - zero) / 0x200 ) + 1	; +1 bootsector
	xor	ebx,	ebx
	mov	ecx,	KERNEL_FILE_SIZE_bytes / 0x200
	mov	edi,	0x00100000
	call	driver_ide_read
