; Author: github.com/vulcanshot
; print all command line arguments and exit
; for 64-bit systems, Linux syscalls

; Variables outside sections are equivalent to preprocessor macros in C
sys_write	                equ	1
sys_exit	                equ	60
sys_stdout	                equ	1

exit_suc                    equ 0

is_program_name_included    equ 0

section .data
	linebreak	db	0x0A	; ASCII character 10, a line break

section .bss

section .text

global _start

_start:
    ; Set registers to zero (just in case! probably not needed)
    xor r12, r12
    xor r13, r13

    mov rbx, [rsp] ; argc = *RSP

    ; Handle is_program_name_included
    mov rax, is_program_name_included ; cmp expects source operand to be register
    cmp rax, 0x0
    jnz loop_start ; Dont offset r13 if we want to print the program name
    inc r12
    mov r13, 0x8
loop_start:
    cmp r12, rbx
    jz exit

    ; Compute address of argument
    ; Safe registers to use: rbx, r12, r13, r14, r15
    add r13, 0x8
    mov rsi, [rsp + r13] ; Set rsi to the value in the address inside [ ]
                         ; In this case, the value is the pointer to the string
    mov r14, rsi ; used for length = rsi - r14
    
next_char:
    cmp BYTE [rsi], 0x0 ; BYTE because we are reading a single character.
    jz print_arg ; If rsi is NUL, jump to end
    add rsi, 0x1 ; Move to next byte
    jmp next_char

print_arg:
    ; Compute length
    sub rsi, r14

    ; Print argument
    mov rax, sys_write
    mov rdi, sys_stdout
    mov rdx, rsi
    mov rsi, r14
    syscall

    ; Print newline
    mov rax, sys_write
    mov rdi, sys_stdout
    mov rsi, linebreak
    mov rdx, 1
    syscall

    ; Loop
    inc r12
    jmp loop_start
exit:
    mov rax, sys_exit
    mov rdi, 0
    syscall