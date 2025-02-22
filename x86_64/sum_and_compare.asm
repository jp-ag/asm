section .data
    value:  equ 120
    num1:   equ 62
    num2:   equ 59
    msg     db "Correct sum!"

section .text
    global _start

_start:
    mov     rax, num1
    mov     rbx, num2
    add     rax, rbx
    cmp     rax, value
    je      .success
    jmp     .exit

.success:
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, msg
    mov     rdx, 12
    syscall
    jmp     .exit

.exit:
    mov     rax, 60
    mov     rdi, 0
    syscall
