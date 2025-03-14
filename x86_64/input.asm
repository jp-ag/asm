%include    './functions/functions.asm'

section .data
	msg1 db		"heya, what's your name buddy", 0
	msg2 db		"cool name, ", 0

section .bss
	%define	buffer_len 64
	buffer: resb buffer_len

section	.text
	global	_start

_start:
	mov		rax, msg1
	call	sprintLF 

	mov		rax, 0 		;; select sys_read 
	mov		rdi, 0 		;; read from stdin
	mov		rsi, buffer	
	mov		rdx, buffer_len
	syscall				;; saves input into rax

	mov		rax, msg2
	call	sprint

	mov		rax, buffer
	call 	sprintLF

	call	exit	
