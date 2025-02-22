;------------------------------------------
; void exit()
; Exit program and restore resources
exit:
    mov     rax, 60
    mov     rdi, 0
    syscall
    ret


;------------------------------------------
; int slen(String msg)
; String length calculation function
slen:
    push    rbx
    mov     rbx, rax
.nextChar:
    cmp     [rax], byte 0 ;; Very important. In x64 we do cmp [reg], byte 0 instead of cmp byte [reg], 0!!
    jz      .finish
    inc     rax
    jmp     .nextChar
.finish:
    sub     rax, rbx
    pop     rbx
    ret


;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    rdx
    push    rdi
    push    rsi
    push    rax ; store string address

    call    slen
    mov     rdx, rax
    pop     rsi
    mov     rax, 1
    mov     rdi, 1
    syscall

    pop     rsi
    pop     rdi
    pop     rdx
    ret


;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
    push    rax

    mov     rax, 0xa
    push    rax ; push line feed to stack
    mov     rax, rsp
    call    sprint
    pop     rax
    pop     rax
    ret


;------------------------------------------
; void iprint(inr num)
; int printing function
iprint:
    push    rax
    push    rcx
    push    rdx
    push    rsi
    mov     rcx, 0  ;; counter
.divideLoop:
    inc     rcx
    mov     rdx, 0
    mov     rsi, 10
    idiv    rsi
    add     rdx, 48
    push    rdx
    cmp     rax, 0
    jnz     .divideLoop
.printLoop:
    dec     rcx
    mov     rax, rsp
    call    sprint
    pop     rax
    cmp     rcx, 0
    jnz     .printLoop

    pop     rsi
    pop     rdx
    pop     rcx
    pop     rax
    ret

;------------------------------------------
; void iprintLF(inr num)
; int printing function
iprintLF:
    call    iprint
    push    rax
    mov     rax, 0xa
    push    rax
    mov     rax, rsp
    call    sprint
    pop     rax
    pop     rax
    ret
