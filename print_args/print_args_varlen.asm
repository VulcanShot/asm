; Author: github.com/vulcanshot
; print all command line arguments and exit
; for 64-bit systems, Linux syscalls

sys_write	equ	1		; the linux WRITE syscall
sys_exit	equ	60		; the linux EXIT syscall
sys_stdout	equ	1		; the file descriptor for standard output (to print/write to)

section .data
	linebreak	db	0x0A	; ASCII character 10, a line break

section .bss

section .text

global _start

_start:
    xor r12, r12
    mov r13, 0x8 ; Set to 0x0 to include program name
loop_start:
    ; Compute address of argument
    ; Safe registers to use: rbx, r12, r13, r14, r15
    add r13, 0x8 ; We don't print RSP
    mov rsi, [rsp + r13]
    mov r14, rsi

    ; Two Methods:
    ; 1. Count length of array and print the whole thing
    ; 2. Print char by char until NUL
    ; Gonna try second cause its easier, but probably less efficient
    test [r14], 0x0 ; test is the AND comparison
    jnz loop_condition

    ; Print character
    mov rax, sys_write
    mov rdi, sys_stdout
    mov rdx, 1
    syscall

    ; Print newline
    mov rax, sys_write
    mov rdi, sys_stdout
    mov rsi, linebreak
    mov rdx, 1
    syscall

loop_condition:
    ; Check loop condition
    inc r12
    cmp r12, [rsp] ; argc = *RSP
    jnz loop_start
exit:
    mov rax, sys_exit
    mov rdi, 0
    syscall