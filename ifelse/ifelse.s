global _start

section .text

_start:
    mov rbx, 01h
    add rbx, 05h
    cmp rbx, 06h ; subtracts a - b
    ;jz exit
    jmp _start

exit:
    mov rax, 60
    mov rdi, 1
    syscall
