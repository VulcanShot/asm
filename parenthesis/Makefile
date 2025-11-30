AS = nasm
ASFLAGS = -f elf64 -g -F dwarf
LD = ld
LDFLAGS = 

ENTRY=parenthesis

$(ENTRY): $(ENTRY).o
	$(LD) $(LDFLAGS) -o $@ $<

$(ENTRY).o: $(ENTRY).asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f *.o $(TARGETS)