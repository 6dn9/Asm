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

myPutd: ;PRINT A DEC NUM GIVEN THROUGH EAX - 2nd attempt
    push ebp        ;<ebp>
    mov ebp, esp    ;point ebp at esp
    push ebx        ;<ebx>
    push ecx        ;<ecx>
    
    xor ecx, ecx    ;clear ecx
    mov ebx, eax    ;copy eax 'input' to ebx
    jmp .loop
.loop:
    cmp ebx, 9
    jg .pushStack
    
    cmp ecx, 0
    jne .popStack
    ;jmp .end
.end:
    pop ecx         ;>/ecx>
    pop ebx         ;</ebx>
    pop ebp         ;</ebp>
    ret             ;return ; oh this ends weirdly becauise i pushed a whole bunch
.pushStack:
    push ebx        ;store last value on stack
    inc ecx         ;count pushes
    
    xor edx, edx    ;clear remainder
    mov eax, ebx    ;prep dividend
    mov esi, 10     ;prep divisor   - why am i using ecx? i need that
    div esi         ; I subbed esi for ecx
    mov ebx, eax    ;put quotient into ebx  
    
    jmp .loop

.popStack:;mult thisidsf hths 
    mov eax, 4
    mul ecx         ;get how far up to look on eax
    mov ebx, eax
    ;im gonna use esi 
    add esp, ebx    ;this should go up 4 * ecx times
    
    mov eax, 10
    mul ecx         ;get ecx * 10
    mov esi, eax    ;get the divisor
    mov eax, dword[esp]  ;might need dword before [] it crashes here
    
    xor edx, edx    ;now i need the remainder of this after dividing by ecx*10
    div esi         ;divide eax by esi
    mov esi, edx    ;put the remainder on ebx
    
    add esi, 48
    push esi
    call putchar
    pop esi
    
    sub esp, ebx ; this is trying to move my pointer back down, but ebx is nuked
    dec ecx
    
    cmp ecx, 0
    jne .popStack
    
    cmp ecx, 0
    je .end
    
    
    ;mov ebx, [esp]
    
    ;jmp .end
    
    ;jmp .end ; was just doing this to test something. 
    
    
    ;add ebx, 48
    ;push ebx
    ;call putchar
    ;pop ebx
    
    
    
main:
    mov ebp, esp ; EBP now marks the beginning of our stack frame

    mov eax, hello
    call myPuts
    
    mov eax, 321
    call myPutd
    
    ;call ovahwiteHerro
    
    ;push hello ; put 4 byte pointer on the stack
    ;call puts  ; call puts() from C standard library
    ;add esp, 4 ; clean up stack
    
    mov eax, 0 ; set EAX as a return value (0 for success)
    ret
