; Recognize balanced parenthesis
; TODO: Write tests (probably not in assembly!)

%include "error.asm"

input_size              equ 256

open_parenthesis        equ '('
closed_parenthesis      equ ')'

carriage_return         equ 13
line_feed               equ 10

section .data
    prompt_m db "Please enter the parenthesis string (max. 255 characters long): "
    prompt_l equ $ - prompt_m

    success_m db "The parenthesis string is valid.", carriage_return, line_feed
    success_l equ $ - success_m

section .bss
    input_buf resb input_size ; Reserve byte (similar to Define byte)

section .text
    global _start

    _start:
        ; Print prompt
        mov rax, 1
        mov rdi, 1
        mov rsi, prompt_m
        mov rdx, prompt_l
        syscall

        ; Get input
        mov rax, 0
        mov rdi, 0
        mov rsi, input_buf
        mov rdx, input_size
        syscall

        mov rbx, input_buf ; String index counter
        xor r12, r12 ; Parenthesis counter (open parenthesis is +1, closed is -1, should never be negative)
    examine_char:
        cmp [rbx], byte open_parenthesis
        jnz not_open_parenthesis
        inc r12
        jmp next_char
    not_open_parenthesis:
        cmp [rbx], byte closed_parenthesis
        jnz not_closed_parenthesis
        dec r12
        jo parenthesis_error
        jmp next_char
    not_closed_parenthesis:
        cmp [rbx], byte line_feed
        jz end
        cmp [rbx], byte 0x0
        jz end
        jmp invalid_char_error
    next_char:
        inc rbx
        jmp examine_char
    end:
        cmp r12, 0x0
        jnz parenthesis_error

        mov rax, 1
        mov rdi, 1
        mov rsi, success_m
        mov rdx, success_l
        syscall

        mov rax, 60
        mov rdi, 0
        syscall