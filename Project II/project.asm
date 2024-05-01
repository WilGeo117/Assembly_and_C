; Filename project.asm
; GLOBALS
global _start ;Declared for linker this is declaring _start (entry point)

; TEXT SECTION
section .text
_start:						;linker entry point
	mov	rdx,	prompt length		;message length see length equ 64 Bit Register
	mov	rs1,	prompt			;message 64 Bit Register
	mov	rbx,	0x01			;file descriptor (stdout) 64 Bit Register
	mov	rax,	0x01			;system call number (sys_write) 64 Bit Register
	syscall					;call kernal 64 Bit System

	mov	rbx,	0x00			;file descriptor (stdin) 64 Bit Register
	mov	rbx,	0x00			;system call number (sys_read) 64 Bit Register
	mov	rsi,	num1			;move address to store to input num1
	syscall					;call kernal 64 Bit System

	mov	rbx,	0x01			;file descriptor (stdout) 64 Bit Register
	mov	rax,	0x01			;system call number (sys_write) 64 Bit Register
	mov	rdx,	64			;length of input num1
	mov	rsi,	num1			;input num1
	syscall					;call kernal 64 Bit System

	mov	rax,	0x3c			;system call number (sys_exit) 64 Bit Register
	mov	rdi,	0x0			;return status 64 Bit Register
	syscall					;call kernal 64 Bit System

; DATA SECTION
section .bss
num1	resb	64				;Reserve 64 Bits for input

section .data
prompt db 'Enter Number : ',0			;string to be printed
prompt_length equ $-prompt			;length of the string
