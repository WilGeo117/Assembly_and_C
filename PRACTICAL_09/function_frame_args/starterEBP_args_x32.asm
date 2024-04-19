; Filename starter.asm

; GLOBALS
global _start ;Declared for linker this is declaring _start (entry point)

STATUS_OK   EQU 0x00                    ; return status okay
SYS_EXIT    EQU 0x01                    ; system exit
SYS_KERNEL  EQU 0x80                    ; kernel call
SYS_STDOUT  EQU 0x01                    ; stdout
SYS_WRITE   EQU 0x04                    ; System write
; TEXT SECTION
section	.text
_start:	                                ; linker entry point
    push    42                          ; pushes 42 onto stack
    call    function                    ; call function
    ; return is in eax, normally we move the value into eax prior to calling int_to_string function
    mov     esi, buffer                 ; Size of Buffer
    call    int_to_string               ; Call int_to_string
    mov     ecx, eax                    ; Result in eax, pass to ecx to print
    mov     edx, 0x4                    ; message length see length equ 32 Bit Register
    call    sys_write                   ; call sys_write
    mov	    edx,  msg_length            ; message length see length equ 32 Bit Register
    mov	    ecx,  message               ; message 32 Bit Register
    call    sys_write
    call    write_endl
    call    system_exit

function:
   push  ebp                            ; base address of the function's frame pushed onto stack
   mov   ebp, esp                       ; place address of stack pointer at top of function frame
   mov   eax, [ebp+8]                   ; dereference value
   add   eax, eax                       ; add 42 to 42
   mov   esp, ebp                       ; place address of function frame on stack pointer
   pop   ebp                            ; base address of the function's frame popped off of stack
   ret                                  ; return

;-------------------------------------------------------
;--------------------System Exit------------------------
;-------------------------------------------------------
system_exit:
    mov     ebx, STATUS_OK              ; return status 32 Bit Registerr
    mov     eax, SYS_EXIT               ; system call number (sys_exit) 32 Bit Register
    int     SYS_KERNEL                  ; call kernel, system call 32 bit System  

;-------------------------------------------------------
;-------------------Write to stdout---------------------
;-------------------------------------------------------
sys_write:
    mov     ebx, SYS_STDOUT             ; file descriptor (stdout) 32 Bit Register
    mov     eax, SYS_WRITE              ; system call number (sys_write) 32 Bit Register
    int     SYS_KERNEL                  ; call kernel, system call 32 bit System
    ret                                 ; return

;-------------------------------------------------------
;---------------------Write ENDL------------------------
;-------------------------------------------------------
write_endl:
    mov     ecx, crlf                   ; message 32 Bit Register
    mov     edx, len_crlf               ; message length see length equ 32 Bit Register
    call    sys_write                   ; call sys_write
    ret  

;-------------------------------------------------------
;----Convert Number into Printable String---------------
; Step through each digit and display
;-------------------------------------------------------
int_to_string:
    add     esi, 9                      ; 0-9 Bytes    
    mov     byte [esi], 0               ; String terminator
    mov     ebx, 10                     ; Move 10 (divide each digit by 10)

.next_digit:
    xor     edx, edx                    ; clear edx register
    div     ebx                         ; eax /= 10
    add     dl, '0'                     ; Convert the remainder to ASCII 
    dec     esi                         ; Store characters in reverse order
    mov     [esi], dl                   ; Move DL register to ESI
    test    eax, eax                    ; Perform a bitwise AND on two operands                   
    jnz     .next_digit                 ; Repeat until eax == 0
    mov     eax, esi                    ; Memory address of first Digit
    ret

;-------------------------------------------------------
;---------------------Section BSS-----------------------
;-------------------------------------------------------    
section .bss
    buffer  resb 4                      ; reserve a byte of memory for buffer atoi

;-------------------------------------------------------
;---------------------Section Data----------------------
;-------------------------------------------------------    
section	.data

message             db 0xA, 'Function Args!', 0xA       ;string to be printed
msg_length          equ $-message                       ;length of the string
crlf                db $0D,$0A                          ; carraige return line feed
len_crlf            equ $-crlf                          ; length crlf
