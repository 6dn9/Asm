;EXTERN puts ; we are going to link in this function from the C standard library
EXTERN putchar ; we are going to link in this function from the C standard library

; Define variables in the data section
SECTION .data
	hello: db 'Hello world! ',0 ; a 0 (NUL) terminated string, and a label to it's address

; Code goes in the text section
SECTION .text
	GLOBAL main ; we are advertising this function as provided by this file

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
    push ebp        ;<ebp>
    mov  ebp, esp   ;set ebp to esp
    
    mov  ebx, eax    ;Copy 'eax input' to ebx
    mov  ecx, 1     ;at least one digit
    push ebx
    jmp .evaluate
.evaluate:
    cmp ebx, 9      ;Check if it's single digit
    jle .print
    jg  .sizeOf
    
    pop  ebx
    push ebx
    jmp
    
.sizeOf:
    inc ecx ;I need to make sure that 
    
    xor edx, edx
    mov eax, ebx
    mov esi, 10
    div esi
    mov ebx, eax
    jmp .evaluate
   
.print:
    ;pop ebx
    ;push ebx
    add ebx, 48     ;convert ebx to ascii
    push ecx
    push ebx
    call putchar
    pop ebx
    pop ecx
    dec ecx
    cmp ecx, 0
    je .exit
    ;jmp .sizePrint

.exit:
    pop ebx
    pop ebp
    ret
    
    
main:
    mov ebp, esp ; EBP now marks the beginning of our stack frame

    mov eax, hello
    call myPuts
    
    mov eax, 6
    call myPutd
    
    mov eax, 0 ; set EAX as a return value (0 for success)
    ret
