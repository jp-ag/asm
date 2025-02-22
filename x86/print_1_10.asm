%include        './functions/functions.asm'

SECTION .text
    global _start

_start:
    mov     eax, 0
printToTen:
    inc     eax
    call    iprintLF
    cmp     eax, 10
    jne     printToTen
    call    exit
