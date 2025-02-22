section .data
    msg db      'I like turtles'

section .text
    global _start

_start:
    mov     rdx, msg
    mov     rsi, rdx
nextChar:
    cmp byte     [rdx], 0 ;; 0 is end of string
    jz      finished
    inc     rdx
    jmp     nextChar
finished:
    sub     rdx, rsi ;; rdx now contains length of string
    mov     rax, 1 ;; sys_write
    mov     rsi, msg
    mov     rdi, 1 ;; sys_out
    syscall
    mov     rax, 60
    mov     rdi, 0
    syscall
