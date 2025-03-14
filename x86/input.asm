%include		'./functions/functions.asm'

SECTION .data
	msg1 db		'Enter your name:', 0h
	msg2 db		'Hello, ',0h

SECTION .bss
	sinput resb	255  ;; reserve 255 byte word 

SECTION .text
	global _start

_start:
	mov		eax, msg1
	call	sprintLF

	mov		edx, 255  	;; number of bytes to read
	mov		ecx, sinput ;; resrved space to store our input (buffer)
	mov		ebx, 0		;; read from stdin file
	mov		eax, 3		;; invoke SYS_READ
	int 	80h

	mov		eax, msg2
	call	sprint
	
	mov		eax, sinput
	call	sprint

	call	exit

