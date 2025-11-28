global _start

section .data

; db -> byte, dw -> word, dd -> double word
arr db 041H, 076H, 065H, 06EH, 067H, 065H, 072H, 073H, 02CH, 020H, 041H, 073H, 073H, 065H, 06DH, 062H, 06CH, 065H, 021H
arr_l equ $-arr

section .text

_start:
    xor rcx, rcx
    mov rcx, arr_l
    lea rsi, [arr]
loop:
    call print_char
    inc rsi
    dec rcx
    jnz loop
    jmp exit

exit:
    mov rax, 60
    mov rdi, 0
    syscall

print_char:
    mov rax, 1
    mov rdi, 1
    ; rsi is already setup
    mov rdx, 1 ; FIXME: Still prints whole thing
    syscall
    ret
