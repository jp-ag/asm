%include        './functions/functions.asm'

SECTION .text
    global _start

_start:
    pop     ecx ; first value on the stack is the number of arguments
    pop     eax ; second value is program name
    dec ecx

nextArg:
    cmp     ecx, 0h ; check if there are any args left
    jz      noMoreArgs
    pop     eax
    call    sprintLF
    dec     ecx
    jmp     nextArg

noMoreArgs:
    call    exit
