nasm -f bin kernel.asm		-o build/kernel
KERNEL_SIZE=`wc -c < build/kernel`

nasm -f bin zero/ap.asm		-o build/ap
nasm -f bin zero.asm		-o build/zero		-dKERNEL_FILE_SIZE_bytes=${KERNEL_SIZE}
ZERO_SIZE=`wc -c < build/zero`

nasm -f bin bootsector.asm	-o build/bootsector	-dZERO_FILE_SIZE_bytes=${ZERO_SIZE}

nasm -f bin disk.asm		-o build/cyjon.img
