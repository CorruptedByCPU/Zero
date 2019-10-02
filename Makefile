system: kernel.asm
	nasm -f bin kernel.asm	-o build/kernel
	nasm -f bin zero.asm	-o build/disk.raw
