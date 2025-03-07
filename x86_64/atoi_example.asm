%include './functions/functions.asm'

section .data
	argError db "Error: No arguments!",0xa,"Usage: ./add_cli num1, num2..."	

section .text
	global _start

_start:
	pop		rcx 	; num of args
	pop		rax 	; remove program name
	dec		rcx
	mov		rdx, 0
	cmp		rcx, 0		; in case zero args
	jne		.nextArg
	mov		rax, argError
	call	sprintLF
	call	exit
.nextArg:
	cmp		rcx, 0
	je		.noMoreArgs
	pop		rax
	call	atoi
	dec		rcx
	add		rdx, rax
	jmp		.nextArg
.noMoreArgs:
	mov		rax, rdx
	call	iprintLF
	call 	exit
	
