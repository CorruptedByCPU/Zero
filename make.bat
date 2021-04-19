..\nasm -f bin kernel.asm		-o build/kernel
FOR /F "usebackq" %%A IN ('build/kernel') DO set KERNEL_SIZE=%%~zA

..\nasm -f bin zero/ap.asm	-o build/ap
..\nasm -f bin zero.asm		-o build/zero		-dKERNEL_FILE_SIZE_bytes=%KERNEL_SIZE%
FOR /F "usebackq" %%A IN ('build/zero') DO set ZERO_SIZE=%%~zA

..\nasm -f bin bootsector.asm	-o build/bootsector	-dZERO_FILE_SIZE_bytes=%ZERO_SIZE%

..\nasm -f bin disk.asm		-o build/cyjon.img

pause
