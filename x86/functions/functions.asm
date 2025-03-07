;------------------------------------------
; void exit()
; Exit program and restore resources
exit:
    mov     eax, 1
    mov     ebx, 0
    int     80h
    ret


;------------------------------------------
; int slen(String msg)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax
.nextchar:
    cmp     byte [eax], 0
    jz      .finished
    inc     eax
    jmp     .nextchar
.finished:
    sub     eax, ebx
    pop     ebx
    ret


;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax ; store address to string
    call    slen

    mov     edx, eax
    pop     eax ; get string back
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    ret


;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
    push    eax
    mov     eax, 0Ah ; push LF into EAX register
    push    eax
    mov     eax, esp ; mov stack pointer that currently points to LF character
    call    sprint
    pop     eax
    pop     eax
    ret

;------------------------------------------
; void iprint(int num)
; int printing function
iprint:
    push    eax
    push    ecx
    push    edx
    push    esi
    mov     ecx, 0  ;; counter
.divideLoop:
    inc     ecx
    mov     edx, 0
    mov     esi, 10
    idiv    esi
    add     edx, 48
    push    edx
    cmp     eax, 0
    jnz     .divideLoop
.printLoop:
    dec     ecx
    mov     eax, esp
    call    sprint
    pop     eax
    cmp     ecx, 0
    jnz     .printLoop

    pop     esi
    pop     edx
    pop     ecx
    pop     eax
    ret


;------------------------------------------
; void iprintLF(int num)
; int printing with line feed function
iprintLF:
    call    iprint

    push    eax
    mov     eax, 0Ah
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret



;------------------------------------------
; int atoi(str num) 
; convert string num to int. Ignore until non-num chars
atoi: 
	push	ecx
	push	ebx
	push	esi
	push	edx				; check line 136
	mov		esi, eax		; move string pointer to esi
	mov		eax, 0	
	mov		ecx, 0
.multiplyLoop:	
	xor		ebx, ebx		; clean ebx lower and upper bits to 0
	mov		bl, [esi+ecx]	; get first char into ebx lower bits
	cmp     bl, 48	; make sure we have the char within our ascii number range
	jl		.finish
    cmp     bl, 57
    jg		.finish
	sub		bl, 48			; make char into num	
	add		eax, ebx
	mov		ebx, 10
	mul		ebx				; remember that mul sends remainder to edx
	inc		ecx
	jmp		.multiplyLoop
.skipChar:
	cmp		bl, 0 			; is the string over or can we skip this char
	je		.finish
	inc		ecx
	jmp		.multiplyLoop
.finish:
	cmp		ecx, 0  		; means no integer value passed to atoi
	je		.restore		
	mov		ebx, 10			; cleanup for extra mult by 10
	div		ebx
.restore:
	pop		edx
	pop		esi
	pop		ebx
	pop		ecx
	ret
