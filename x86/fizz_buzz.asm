%include        './functions/functions.asm'

SECTION .data
    msgFizz     db 'Fizz',0h
    msgBuzz     db 'Buzz',0h

SECTION .text
    global _start

_start: ;; print all nums 1 to 100. replace if div by 3 Fizz, div by 5 Buzz
    mov     ecx, 0
.nextNum:
    inc     ecx
.isFizz:
    mov     edx, 0
    mov     eax, ecx ;; get the num to divide
    mov     ebx, 3
    div     ebx
    mov     esi, edx ;; is Fizz bool
    cmp     edx, 0
    jne     .isBuzz
    mov     eax, msgFizz
    call    sprint
.isBuzz:
    mov     edx, 0
    mov     eax, ecx
    mov     ebx, 5
    div     ebx
    mov     edi, edx ;; is Buzz bool
    cmp     edx, 0
    jne     .isInt
    mov     eax, msgBuzz
    call    sprint
.isInt:
    cmp     esi, 0
    je     .continue
    cmp     edi, 0
    je     .continue
    mov     eax, ecx
    call    iprint
.continue:
    mov     eax, 0Ah ;; print LF
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 100  ;; are we done?
    jne     .nextNum
    call    exit
