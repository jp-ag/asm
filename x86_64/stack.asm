section .data
    SYS_WRITE   equ 1
    STD_OUT      equ 1
    SYS_EXIT    equ 60
    EXIT_CODE   equ 0

    NEW_LINE    db 0xa
    WRONG_ARG   db "Must be two command line arguments", 0xa

section .text
    global _start

_start:
    pop     rcx ;; argc
    cmp     rcx, 3 ;; check argc
    jne     argError

    add     rsp, 8 ;; skip argv[0] - program name
    pop     rsi ;; address of first argument
    call    str_to_int ;; integer value goes to rax

    mov     r10, rax
    pop     rsi ;; address of second argument
    call    str_to_int
    mov     r11, rax

    add     r10, r11
    mov     rax, r10
    xor     r12, r12 ;; sets r12 to 0
    jmp     int_to_str

str_to_int:
    xor     rax, rax ;; accumulator
    mov     rcx, 10 ;; base for multiplication
next:
    cmp     [rsi], byte 0 ;; check that it is end of string
    je      return_str ;; if it is null we return
    mov     bl, [rsi] ;; copy value to one byte `bl` register, which is the lower byte of `rbx`
    sub     bl, 48 ;; subtract 48 for ascii table
    mul     rcx ;; multiplies rax on rcx (which is 10)
    add     rax, rbx
    inc     rsi ;; increment rsi to get next byte and loop again
    jmp     next
return_str:
    ret

int_to_str:
    mov     rdx, 0 ;; remainder from divison
    mov     rbx, 10 ;; base
    div     rbx ;; divide rax per rbx. Remainder goes in rdx and whole part in rax
    add     rdx, 48 ;; to get ascii symbol for number
    ;;add     rdx, 0x0 ;; to end all strings with 0x0
    push    rdx
    inc     r12 ;; this was set to 0 in _start. It is going to tell us how many bytes to print
    cmp     rax, 0x0
    jne     int_to_str
    jmp     print

print:
    mov     rax, 1
    mul     r12 ;; number of digits in num
    mov     r12, 8 ;; in bytes
    mul     r12
    mov     rdx, rax ;; number of bytes to print in rdx

    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, rsp ;; pointer to the top of the stack (start of the string)
    syscall
    jmp printNewline

printNewline:
    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, NEW_LINE
    mov     rdx, 1
    syscall
    jmp exit

argError:
    mov     rax, SYS_WRITE
    mov     rdi, STD_OUT
    mov     rsi, WRONG_ARG
    mov     rdx, 34
    syscall
    jmp     exit

exit:
    mov     rax, SYS_EXIT
    mov     rdi, EXIT_CODE
    syscall
