;===============================================================================
; Copyright (C) by vLock.dev
;===============================================================================

struc	KERNEL_VIDEO_STRUCTURE_MODE_INFO_BLOCK
	.mode_attributes		resb	2
	.win_a_attributes		resb	1
	.win_b_attributes		resb	1
	.win_granularity		resb	2
	.win_size			resb	2
	.win_a_segment			resb	2
	.win_b_segment			resb	2
	.win_func_ptr			resb	4
	.bytes_per_scanline		resb	2
	.x_resolution			resb	2
	.y_resolution			resb	2
	.x_char_size			resb	1
	.y_char_size			resb	1
	.number_of_planes		resb	1
	.bits_per_pixel			resb	1
	.number_of_banks		resb	1
	.memory_model			resb	1
	.bank_size			resb	1
	.number_of_image_pages		resb	1
	.reserved0			resb	1
	.red_mask_size			resb	1
	.red_field_position		resb	1
	.green_mask_size		resb	1
	.green_field_position		resb	1
	.blue_mask_size			resb	1
	.blue_field_position		resb	1
	.rsvd_mask_size			resb	1
	.direct_color_mode_info		resb	2
	.physical_base_address		resb	4
	.reserved1			resb	212
endstruc

; 64 bitowy kod jądra systemu
[BITS 64]

; położenie kodu jądra systemu w pamięci fizycznej
[ORG 0x0000000000100000]

;===============================================================================
kernel:
	; domyślny kolor tła
	mov	eax,	0x00FF0000	; czerwony

	; pobierz ilość pikseli na osi Y
	mov	bx,	word [rdx + KERNEL_VIDEO_STRUCTURE_MODE_INFO_BLOCK.y_resolution]

	; pobierz adres fizyczny przestrzeni pamięci karty graficznej
	mov	edi,	dword [rdx + KERNEL_VIDEO_STRUCTURE_MODE_INFO_BLOCK.physical_base_address]

.loop:
	; pobierz ilość pikseli na osi X
	mov	cx,	word [rdx + KERNEL_VIDEO_STRUCTURE_MODE_INFO_BLOCK.x_resolution]
	rep	stosd

	; wypełniono całą przestrzeń?
	dec	bx
	jnz	.loop	; nie

	; zatrzymaj dalsze wykonywanie kodu jądra systemu
	jmp	$

; wyrównaj kod jądra systemu do pełnego rozmiaru strony
align	0x1000
