all: kernel.iso

AS = nasm
ASFLAGS = -f elf64 -g
LDFLAGS = -g -m elf_x86_64 -L/usr/lib/gcc/`gcc -dumpmachine`/`gcc -dumpversion`/
LDLIBS  = -lgcc
CXXFLAGS=-Wwrite-strings -g -ffreestanding -std=c++14 -mcmodel=large \
	-mno-mmx -mno-sse -mno-sse2 -mno-sse3 -mno-3dnow -DKERNEL_$(ARCH)

KERNEL_OBJS =  src/kernel/bootstrap/x86_64/bootstrap.asm.o src/kernel/entrypoint.asm.o

kernel.bin: $(KERNEL_OBJS) 
	$(LD) $(LDFLAGS) $(LDLIBS) $^ -T platforms/$(ARCH)/kernel.ld -o $@
	objcopy $@ -O elf32-i386 $@
.PHONY : kernel.bin

sysroot: kernel.bin
	rm   -rf sysroot
	mkdir -p sysroot
	mkdir -p sysroot/boot
	cp grub/*  -r sysroot/
	cp kernel.bin sysroot/boot/kernel.bin

kernel.iso: sysroot kernel.bin
	grub-mkrescue -o $@ sysroot
.PHONY : kernel.iso

kernel:  kernel.iso
disk:    kernel.iso
cdrom:   kernel.iso
cd:      kernel.iso

%.asm.o: %.asm
	$(AS) $(ASFLAGS) $(INCLUDE_ARGS) $< -o $@

%.cpp.o: %.cpp
	$(CXX) $(CXXFLAGS) $< -c \
		$(INCLUDE_ARGS) -o $@

%.c.o: %.c
	$(CC) $(CFLAGS) -std=c11 $< -c -ffreestanding\
		$(INCLUDE_ARGS) -o $@
