;EXTERN puts ; we are going to link in this function from the C standard library
EXTERN putchar ; we are going to link in this function from the C standard library

; Define variables in the data section
SECTION .data
	hello: db 'Hello world!',0 ; a 0 (NUL) terminated string, and a label to it's address

; Code goes in the text section
SECTION .text
	GLOBAL main ; we are advertising this function as provided by this file
ovahwiteHerro:
    push ebp
    mov ebp, esp
    push ebx
    push edx
    
    mov eax, 11
    mov ebx, hello
.loop:
    movzx edx, byte [ebx]
    cmp edx, 'l'
    jne .skip
    mov byte [ebx], '*'
.skip:
    
    inc ebx ; char ptr
    dec eax ; count-down from 11
    jnz .loop ; loop if not finished counting
    
    pop edx
    pop ebx
    pop ebp
    ret

myPuts:
    push ebp
    mov ebp, esp
    push ebx
    mov esi, eax
.loop:
    movzx ebx, byte [esi]   ;put a byte from eax onto ebx
    inc esi

    cmp ebx, 0              ;see if it's a space
    jz .end                 ;go back to loop if not space

    push ebx
    call putchar            ;put that char brah
    add esp, 4
    jmp .loop

.end:
    pop ebx
    pop ebp
    ret

myPutd:
    push ebp
    mov ebp, esp
    
    mov ebx, eax
    
.loop:
    cmp ebx, 0
    jmp .loop
    
    pop ebp
    ret

main:
    mov ebp, esp ; EBP now marks the beginning of our stack frame

    mov eax, hello
    call myPuts
    
    mov eax, 54321
    call myPutd
    
    ;call ovahwiteHerro
    
    ;push hello ; put 4 byte pointer on the stack
    ;call puts  ; call puts() from C standard library
    ;add esp, 4 ; clean up stack
    
    mov eax, 0 ; set EAX as a return value (0 for success)
    ret