section .data
    parenthesis_error_m db "The parenthesis string is not valid.", carriage_return, line_feed
    parenthesis_error_l equ $ - parenthesis_error_m

    invalid_char_error_m db "Invalid character found. Exiting.", carriage_return, line_feed
    invalid_char_error_l equ $ - invalid_char_error_m

section .text
    parenthesis_error:
        mov rax, 1
        mov rdi, 2
        mov rsi, parenthesis_error_m
        mov rdx, parenthesis_error_l
        syscall
        jmp input_error_exit
    invalid_char_error:
        mov rax, 1
        mov rdi, 2
        mov rsi, invalid_char_error_m
        mov rdx, invalid_char_error_l
        syscall
        jmp input_error_exit
    input_error_exit:
        mov rax, 60
        mov rdi, 65 ; Data format error
        syscall