;===============================================================================
; Copyright (C) by vLock.dev
;===============================================================================

;===============================================================================
zero_storage:
	; inicjalizuj dostępne nośniki
	call	driver_ide_init

	xchg	bx,bx
	mov	eax,	((zero_end - zero) + 0x200) / 0x200
	xor	ebx,	ebx
	mov	ecx,	1
	mov	edi,	0x100000
	call	driver_ide_read
