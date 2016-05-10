ARCH = i686

CROSS_PREFIX = $(ARCH)-elf-

LD = $(CROSS_PREFIX)ld
LDFLAGS = -Tkernel.ld

AS = $(CROSS_PREFIX)as

CC = clang
CFLAGS = --target=$(ARCH)-pc-none-elf -ffreestanding

SWIFT = swiftc
SWIFTFLAGS = -emit-library -emit-bc

OBJS = start.o main.o mulodi4.o runtime.o globalinit.o


all: build


build: kernel.elf

kernel.elf: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o kernel.elf

%.o: %.S
	$(AS) $< -o $@

%.o: %.swift
	$(SWIFT) $(SWIFTFLAGS) $< -o $@.bc
	$(CC) $(CFLAGS) -c $@.bc -o $@


clean:
	rm -f count *.o *.bc


run:
	qemu-system-i386 -kernel kernel.elf
