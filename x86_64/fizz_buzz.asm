%include        './functions/functions.asm'

section .data
    msgFizz     db  'Fizz', 0h
    msgBuzz     db  'Buzz', 0h

section .text
    global  _start

_start:
    mov     rcx, 0
.nextNum:
    inc     rcx
.isFizz:
    mov     rdx, 0 ;; remainder
    mov     rax, rcx
    mov     rbx, 3
    div     rbx
    mov     rsi, rdx ;; is fizz bool
    cmp     rdx, 0
    jne     .isBuzz
    mov     rax, msgFizz
    call    sprint
.isBuzz:
    mov     rdx, 0 ;; remainder
    mov     rax, rcx
    mov     rbx, 5
    div     rbx
    mov     rdi, rdx ;; is fizz bool
    cmp     rdx, 0
    jne     .isInt
    mov     rax, msgBuzz
    call    sprint 
.isInt:
    cmp     rdi, 0
    je      .continue
    cmp     rsi, 0
    je      .continue
    mov     rax, rcx
    call    iprint
.continue:
    mov     rax, 0xa ;; print LF
    push    rax ;; push line feed to stack
    mov     rax, rsp
    call    sprint
    pop     rax
    cmp     rcx, 100 
    jne     .nextNum
    call    exit
