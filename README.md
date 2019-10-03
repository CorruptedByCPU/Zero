# Zero

Program rozruchowy w czystym języku asemblera dla plików "jądra systemu" działający w 16, 32 i 64 bitowym trybie procesora.

Wymagania:

- kompilator Nasm (https://nasm.us)
- wirtualizator Qemu (https://www.qemu.org)

Kompilacja:

	# (GNU/Linux)
	make

	# MS Windows
	nasm -f bin kernel.asm	-o build/kernel
	nasm -f bin zero.asm	-o build/disk.raw

Uruchomienie:

	qemu-system-x86_64 -hda build\disk.raw -m 2
