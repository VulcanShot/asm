AS = nasm
LD = ld

# Flags: 64-bit ELF format, with DWARF debug info (useful for GDB)
ASFLAGS = -f elf64 -g -F dwarf
LDFLAGS = 

TARGETS = args print_args print_args_varlen

# Default target: Build all executables
all: $(TARGETS)

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

%: %.o
	$(LD) $(LDFLAGS) -o $@ $<

clean:
	rm -f *.o $(TARGETS)