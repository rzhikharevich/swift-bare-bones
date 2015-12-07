ARCH = i686

CROSS_PREFIX = $(ARCH)-elf-

LD = $(CROSS_PREFIX)ld
LDFLAGS = -Tkernel.ld

AS = $(CROSS_PREFIX)as

CC = clang
CFLAGS = --target=$(ARCH)-pc-none-elf -ffreestanding

SWIFT = swiftc
SWIFTFLAGS = -emit-library -emit-ir

OBJS = start.o main.o mulodi4.o runtime.o globalinit.o


all: build


build: kernel.elf

kernel.elf: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o kernel.elf

%.o: %.S
	$(AS) $< -o $@

%.o: %.swift
	$(SWIFT) $(SWIFTFLAGS) $< -o $@.ll
	$(CC) $(CFLAGS) -c $@.ll -o $@


clean:
	rm -f count *.o *.ll


run:
	qemu-system-i386 -kernel kernel.elf
