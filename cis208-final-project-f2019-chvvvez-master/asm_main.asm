;
; file: asm_main.asm

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
        syswrite: equ 4
        stdout: equ 1
        exit: equ 1
        SUCCESS: equ 0
        kernelcall: equ 80h

a1 dd 180,32,455,499,388,480,239,346,257,84
a2 dd 0,0,0,0,0,0,0,0,0,0
a3 times 10 dd 0
a4 times 10 dd 0
integer dd 10
length dd 10
m1 dd "Array One", 0
m2 dd "Array Two", 0
m3 dd "Array Three", 0
m4 dd "Array Four", 0

; uninitialized data is put in the .bss segment
;
segment .bss
;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************
	mov eax, m1
	call print_string
	call print_nl
	mov esi, a1
	mov ecx, 10
ha:
	lodsd
	call print_int
	call print_nl
	loop ha
	mov eax, a1 ;parameter 1
	push eax

	mov eax,[length]	;parameter 2
	push eax
	
 	mov eax, [integer]	;parameter 3
	push eax
	
	call stack1
	call stack2
	mov eax, m2
	call print_string
	call print_nl
	mov esi, a2
	mov ecx, 10
looop:
	lodsd 
	call print_int
	call print_nl
	loop looop
	add esp, 12
	
	mov eax, m3
	call print_string
	call print_nl
	mov esi, a3
	mov ecx, 10
loop:
	lodsd 
	call print_int
	call print_nl
	loop loop
	add esp, 12
	

	mov eax, a1
	push eax
	
	mov eax, a3
	push eax
	call stack3
	mov eax, m4
	call print_string
	call print_nl
	mov esi, a4
	mov ecx, 10
fine:
	lodsd 
	call print_int
	call print_nl
	loop fine
	add esp, 8		
; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret
	
stack1:
	push ebp
	mov ebp, esp
	cld
	mov esi,[ebp +16]
	mov ecx,[ebp +12]
	mov ebx,[ebp+8]
	mov edi, a2
lp:
	mov edx, [esi]
	add  edx, ebx
	mov eax, edx
	stosd
	lodsd
	loop lp
	pop ebp
	ret
stack2:
	push ebp
	mov ebp, esp
	cld
	mov esi,[ebp +16]
	mov ecx,[ebp +12]
	mov ebx,[ebp+8]
	mov edi, a3
leap:
	mov edx, [esi]
	imul edx, ebx
	mov eax, edx
	stosd
	lodsd
	loop leap
	pop ebp
	ret

stack3:
	push ebp 
	mov ebp, esp
	cld
	mov esi, [ebp+12]
	mov ebx, [ebp+8]
	mov ecx, 10
	mov edi, a4
final:
	mov edx, [esi]
	add edx,[ebx]
	mov eax, edx
	stosd
	add ebx, 4 
	lodsd
	loop final

	pop ebp
	ret






