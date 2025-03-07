%include        './functions/functions.asm'

SECTION .data
    argsMsg     db 'Error: No arguments!',0Ah,'Usage: ./add_cli num1 num2...', 0Ah

SECTION .text
    global _start

_start:
    pop     ecx ; get num of arguments passed
    pop     eax ; remove program name from stack
	dec		ecx
    mov     edx, 0
	cmp		ecx, 0
	jne		.nextArg
	mov		eax, argsMsg
	call	sprint
	call	exit
.nextArg:
    cmp		ecx, 0	; check if any args left
	jz		.noMoreArgs
	pop     eax
    call    atoi
    dec     ecx
    add     edx, eax
    jmp    .nextArg
.noMoreArgs:
    mov     eax, edx
    call    iprintLF
    call    exit
