; Filename starter.asm

; GLOBALS
global _start ;Declared for linker this is declaring _start (entry point)

; TEXT SECTION
section	.text
_start:	                                 ; linker entry point

   call  function                         ; call function

   mov	edx,  msg_length                 ; message length see length equ 32 Bit Register
   
   mov	ecx,  message                    ; message 32 Bit Register

   mov	ebx,  0x1                        ; file descriptor (stdout) 32 Bit Register
   
   mov	eax,  0x4                        ; system call number (sys_write) 32 Bit Register

   int	0x80                             ; call kernel 32 bit System
   	
   mov	eax,  0x1                        ; system call number (sys_exit) 32 Bit Register

   mov   ebx,  0x0                        ; return status 32 Bit Register

   int	0x80                             ; call kernel, system call 32 bit System

function:
   push  ebp                              ; base address of the function's frame pushed onto stack

   mov   ebp, esp                         ; place address of stack pointer at top of function frame

   mov   [esp],   byte 'E'                ; move byte onto ESP stack pointer

   mov   [esp+1], byte 'S'                ; move byte onto ESP stack pointer

   mov   [esp+2], byte 'P'                ; move byte onto ESP stack pointer

   mov	edx,  3                          ; message length see length equ 32 Bit Register

   mov	ecx,  esp                        ; message 32 Bit Register

   mov	ebx,  0x1                        ; file descriptor (stdout) 32 Bit Register
   
   mov	eax,  0x4                        ; system call number (sys_write) 32 Bit Register

   int	0x80                             ; call kernel 32 bit System

   mov   esp, ebp                         ; place address of function frame on stack pointer

   pop   ebp                              ; base address of the function's frame popped off of stack

   ret                                    ; return

; DATA SECTION
section	.data

message db 0xA, 'Function Frame!', 0xA    ;string to be printed
msg_length equ $-message                  ;length of the string
