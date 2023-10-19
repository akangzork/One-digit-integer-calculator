%macro print 2
	mov rax, 1 
	mov rdi, 1 
	mov rsi, %1 
	mov rdx, %2 
	syscall
%endmacro

%macro scan 2
	mov rax, 0 
	mov rdi, 0 
	mov rsi, %1 
	mov rdx, %2 
	syscall
%endmacro

section .bss
	buffer resb 16
	
section .data
	msg1 db "Enter Operations String: ", 0
	msg2 db " = ", 0
	result db 10, 0
	
section .text
	global _start

_start:
	print msg1, 25
	
	scan buffer, 16
	
	mov al, byte[buffer]
	sub al, '0'
	mov bl, byte[buffer + 2]
	sub bl, '0'
	cmp byte[buffer + 1], '+'
	je add_op
	cmp byte[buffer + 1], '-'
	je subtract_op
	cmp byte[buffer + 1], '*'
	je multiply_op
	cmp byte[buffer + 1], '/'
	je divide_op
	
add_op:
	add al, bl
	jmp printout
	
subtract_op:
	sub al, bl
	jmp printout
	
multiply_op:
	mul bl
	jmp printout
	
divide_op:
	xor rdx, rdx
	div bl
	jmp printout
	
printout:
	add al, '0'
	mov [buffer+4], al
	
	print buffer, 9
	
	print msg2, 3
	
	print buffer+4, 1
	
	print result, 1
	
	mov rax, 60
	mov rdi, 0
	syscall
	
