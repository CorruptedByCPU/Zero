# Zero

64 bit bootloader for Cyjon operating system.

### Software:

  - Qemu 5.0.0 or Bochs 2.6.11 (no SMP support on MS/Windows)
  - Nasm 2.15.1
  - Atom (with package https://atom.io/packages/language-assembly) or your own IDE ;)

### Compilation (GNU/Linux)

	# select a resolution supported by the BIOS
	WIDTH=640
	HEIGHT=480

	nasm -f bin kernel.asm		-o build/kernel
	KERNEL_SIZE=`wc -c < build/kernel`

	nasm -f bin zero.asm		-o build/zero		-dKERNEL_FILE_SIZE_bytes=${KERNEL_SIZE} -dSELECTED_VIDEO_WIDTH_pixel=${WIDTH} -dSELECTED_VIDEO_HEIGHT_pixel=${HEIGHT}
	ZERO_SIZE=`wc -c < build/zero`

	nasm -f bin bootsector.asm	-o build/bootsector	-dZERO_FILE_SIZE_bytes=${ZERO_SIZE}

	nasm -f bin disk.asm		-o build/disk.raw

### Compilation (MS/Windows):

	# select a resolution supported by the BIOS
	set WIDTH=640
	set HEIGHT=480

	nasm -f bin kernel.asm		-o build/kernel
	FOR /F "usebackq" %%A IN ('build/kernel') DO set KERNEL_SIZE=%%~zA

	nasm -f bin zero.asm		-o build/zero		-dKERNEL_FILE_SIZE_bytes=%KERNEL_SIZE% -dSELECTED_VIDEO_WIDTH_pixel=%WIDTH% -dSELECTED_VIDEO_HEIGHT_pixel=%HEIGHT%
	FOR /F "usebackq" %%A IN ('build/zero') DO set ZERO_SIZE=%%~zA

	nasm -f bin bootsector.asm	-o build/bootsector	-dZERO_FILE_SIZE_bytes=%ZERO_SIZE%

	nasm -f bin disk.asm		-o build/disk.raw

### Exec:

	# 2 MiB RAM, no network, hard disk connected to IDE controller
	qemu-system-x86_64 -hda file=build/disk.raw -m 2
