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
    ;DEFAULT START
    push ebp        ;<ebp>
    mov  ebp, esp   ;set ebp to esp
    
    ;PREPARE FUNCTION
    mov  ebx, eax   ;Copy 'eax input' to ebx
    mov  ecx, 1     ;Print at least once
    push ebx
    ;jmp .evaluate
    
.evaluate:
    ;FIND LENGTH
    cmp ebx, 9      ;Check if it's single digit
    jle .printEvaluate      ;If it's less than 9, print
    

    ;jg  .sizeOf     ;--Can I do this without running another cmp
    ;p ebx         ;get the old ebx number
    
.sizeOf:
    mov esi, 10     ;--Can I use just 10 instead of esi for div and mul
        
    ;DIVIDE ORIGINAL
    xor edx, edx
    mov eax, ebx
    div esi         ;number
    mov ebx, eax
    
    ;KEEP TRACK
    xor edx, edx
    mov eax, ecx
    mul esi         ;number
    mov ecx, eax
    
    jmp .evaluate

.printEvaluate:

    pop ebx
    push ebx        ;backup the real ebx
    ;cmp ecx, 1      ;If the number was counter to 
    ;jg .makeSmall   ;Get smaller
    ;jle .print      ;If the counter was 1 or less, print

.makeSmall:
    mov esi, 10     ;--Can I use just 10 instead of esi for div and mul
    
    ;SHRINK THE NUMBER
    xor edx, edx
    mov eax, ebx
    div ecx
    mov ebx, eax
    mov edi, edx        ;store the remainder on edi
    
    ;SHRINK THE SHRINK :)
    xor edx, edx
    mov eax, ecx
    div esi
    mov ecx, eax
    
    jmp .print
    
           
.print:
    ;push ebx        ;save the num before adding
    add ebx, 48     ;convert ebx to ascii
    push edi        ;put the next numbah up
    push ecx        ;save the counter
    push ebx        ;give putchar the ebx.
    call putchar
    pop ebx
    pop ecx
    pop edi
    
    mov ebx, edi    ;set the previous remainder 
    cmp ecx, 0
    je .exit
    jmp .makeSmall

.exit:
    pop ebx
    pop ebp
    ret
    
    
main:
    mov ebp, esp ; EBP now marks the beginning of our stack frame

    mov eax, hello
    call myPuts
    
    mov eax, -1034
    call myPutd
    
    mov eax, 0 ; set EAX as a return value (0 for success)
    ret
