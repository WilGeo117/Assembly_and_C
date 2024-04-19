; Filename starter.asm

; GLOBALS
global _start ;Declared for linker this is declaring _start (entry point)

; TEXT SECTION
section	.text
_start:	                                 ;linker entry point

   mov   ecx, gsm                         ;initialse ecx with value of gsm (Game State Managment)

gameloop:
   dec   ecx                              ;decrement as its a do while

   mov   [temp], ecx                      ;move register value to from ecx to temp (GSM state Stored)

   mov	edx,  msg_length                 ;message length see length equ 32 Bit Register
   
   mov	ecx,  message                    ;message 32 Bit Register
   
   mov	eax,  0x4                        ;system call number (sys_write) 32 Bit Register

   mov	ebx,  0x1                        ;file descriptor (stdout) 32 Bit Register

   int	0x80                             ;call kernel 32 bit System

   mov   ecx, [temp]                      ;move temp (GSM state Stored) value to ecx
   
   jnz gameloop                           ;jump if not zero
	
   mov	eax,  0x1                        ;system call number (sys_exit) 32 Bit Register

   mov   ebx,  0x0                        ;return status 32 Bit Register

   int	0x80                             ;call kernel, system call 32 bit System

; DATA SECTION
section	.data

gsm equ 4                                 ;Game State Managment gsm (set at 10 to loop 1 times)
temp dd 100h                              ;temp memory location to store decremented value

message db 'Game Loopy', 0xA              ;string to be printed
msg_length equ $-message                  ;length of the string
