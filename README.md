# Zero

Program rozruchowy w czystym języku asemblera dla plików "jądra systemu" działający w 16, 32 i 64 bitowym trybie procesora.

#### Wymagania:

- kompilator Nasm (https://nasm.us)
- wirtualizator Qemu (https://www.qemu.org)

#### Modyfikacja:

Na początku pliku *config.asm* znajduje się linia zmieniająca tryb procesora w jaki zostanie on przekazany do jądra systemu.
Tryb 16 bitowy, uruchamia kod pod adresem fizycznym 0x1000, natomiast tryb 32 i 64 bitowy pod adresem fizycznym/logicznym 0x100000

	;---
	; tryb programu rozruchowego
	;---------------------------
	STATIC_ZERO_bit_mode equ 64 ; dostępne wartości: 16, 32 i 64

#### Kompilacja:

	# (GNU/Linux)
	make

	# MS Windows
	nasm -f bin kernel.asm	-o build/kernel
	nasm -f bin zero.asm	-o build/disk.raw

#### Uruchomienie:

	qemu-system-x86_64 -hda build\disk.raw -m 2
