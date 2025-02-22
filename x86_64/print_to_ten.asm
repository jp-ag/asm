%include './functions/functions.asm'

section .text
    global _start

_start:
    mov     rax, 10
    call    iprint
    call    exit
;.printLoop:
;    inc     rax
;    call    iprint
;    cmp     rax, 10
;    jne     .printLoop
;    call    exit
