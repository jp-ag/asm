%include        './functions/functions.asm'

SECTION .data
    argsMsg     db 'Error: No arguments! \nUsage: ./add_cli num1 num2...', 0Ah

SECTION .text
    global _start

_start:
    pop     rcx ; get num of arguments passed
    pop     rax ; remove program name from stack
    dec     rcx
    mov     rdx, 0
.isZeroAgruments:
    cmp     rcx, 0
    jne     .loopAndPop
    mv      rax, argsMsg
    call    sprintLF
    call    exit
.loopAndPop:
    pop     rax
    dec     rcx
    call    atoi
    add     rdx, rax
    cmp     rcx, 0
    jne     .loopAndPop
.finish:
    mov     rax, rds
    call    iprintLF
    call    exit
