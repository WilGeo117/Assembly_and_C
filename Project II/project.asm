; Filename: project.asm
; GLOBALS
global _start ; Declared for linker, this is declaring _start (entry point)

; TEXT SECTION
section .text
_start:
    mov     rdx,    prompt_length   ; message length
    mov     rsi,    prompt          ; message address
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall

    mov     rsi,    num1            ; address to store input
    mov     rdi,    0               ; file descriptor (stdin)
    mov     rax,    0               ; system call number (sys_read)
    syscall

    mov     rdx,    prompt_length   ; message length
    mov     rsi,    prompt          ; message address
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall

    mov     rsi,    num2            ; address to store input
    mov     rdi,    0               ; file descriptor (stdin)
    mov     rax,    0               ; system call number (sys_read)
    syscall

    xor     rdx,    rdx             ; clear rdx for later use
    mov     rsi,    num1            ; pointer to the string
    call    atoi                    ; convert ASCII to integer
    mov     r8,     rax             ; store the result in r8

    xor     rdx,    rdx             ; clear rdx for later use
    mov     rsi,    num2            ; pointer to the string
    call    atoi                    ; convert ASCII to integer

    add     rax,    r8              ; add first number to second number

    mov     rdx,    result_msg_len  ; length of the result message
    mov     rsi,    result_msg      ; address of the result message
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall

    mov     rdx,    64              ; length of the result
    mov     rsi,    result          ; address of the result
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall

    mov     rax,    60              ; system call number (sys_exit)
    xor     rdi,    rdi             ; return status
    syscall                         ; call kernel

; Function to convert ASCII to integer
; Input: rsi - address of the string
; Output: rax - integer value
atoi:
    xor     rax,    rax             ; Clear rax
.loop:
    lodsb                           ; Load byte into al from address in rsi and increment rsi
    cmp     al,     0               ; Check for null terminator
    je      .done                   ; If null terminator found, we are done
    sub     al,    '0'              ; Convert ASCII to integer
    imul    rax,    rax,   10       ; Multiply current value by 10
    add     rax,    rdi             ; Add value of current digit
    jmp     .loop                   ; Repeat for next digit
.done:
    ret

; DATA SECTION
section .bss
    num1            resb    64      ; Reserve space for first number
    num2            resb    64      ; Reserve space for second number
    result          resb    64      ; Reserve space for result

section .data
    prompt          db  'Enter First Number: ', 0    ; String to be printed
    prompt_length   equ $ - prompt                    ; Length of the string
    result_msg      db  'Result is: ', 0             ; Result message
    result_msg_len  equ $ - result_msg               ; Length of the result message
