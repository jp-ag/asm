%include './functions/functions.asm'

section .text
    global _start

_start:
    mov     rax, 0
.printLoop:
    inc     rax
    call    iprintLF
    cmp     rax, 10
    jne     .printLoop
    call    exit
