; Author: github.com/vulcanshot
; print all command line arguments (5 characters) and exit
; for 64-bit systems, Linux syscalls
; TODO: calculate the length of the strings.

sys_write	equ	1		; the linux WRITE syscall
sys_exit	equ	60		; the linux EXIT syscall
sys_stdout	equ	1		; the file descriptor for standard output (to print/write to)

length		equ	5		; the length of the string we wish to print (fixed string length of the arguments)

section .data
	linebreak	db	0x0A	; ASCII character 10, a line break

section .bss

section .text

global _start

; Remember argv is an arrray of pointers.
; Each pointer is a QWORD (8 bytes = 64 bits)
; Because we are in 64-bit (!)

; An altenative method is to use POP
; However, it has the side-effect of being destructive

_start:
    xor r12, r12
    mov r13, 0x8 ; Set to 0x0 to include program name
loop:
    ; Compute address of argument
    ; Safe registers to use: rbx, r12, r13, r14, r15
    add r13, 0x8 ; We don't print RSP
    mov rsi, [rsp + r13]

    ; Print argument
    mov rax, sys_write
    mov rdi, sys_stdout
    mov rdx, length
    syscall

    ; Print newline
    mov rax, sys_write
    mov rdi, sys_stdout
    mov rsi, linebreak
    mov rdx, 1
    syscall

    ; Check loop condition
    inc r12
    cmp r12, [rsp] ; argc = *RSP
    jnz loop
exit:
    mov rax, sys_exit
    mov rdi, 0
    syscall