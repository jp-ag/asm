%include    './functions/functions.asm'

;; Definition of the data section
section .data
    ;; String `msg` variable with value `hello, world!`
    msg db      "hello, world!"

;; Definition of the text section
section .text
    ;; Reference to the entry point of program
    ;; Mark the `_start` symbol as global so that it is visible to the linkes
    global _start

;; Entry point
_start:
    mov     rax, msg
    call    sprintLF


    call    exit
