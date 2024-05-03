; Filename: project.asm
; GLOBALS
global _start ; Declared for linker, this is declaring _start (entry point)

; TEXT SECTION
section .text
_start:
    ; Print "Enter First Number: "
    mov     rdx,    prompt1_length  ; message length
    mov     rsi,    prompt1         ; message address
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall                         ; call kernel

    ; Read first number
    mov     rsi,    num1            ; address to store input
    mov     rdi,    0               ; file descriptor (stdin)
    mov     rax,    0               ; system call number (sys_read)
    syscall                         ; call kernel

    ; Print "Enter Second Number: "
    mov     rdx,    prompt2_length  ; message length
    mov     rsi,    prompt2         ; message address
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall                         ; call kernel

    ; Read second number
    mov     rsi,    num2            ; address to store input
    mov     rdi,    0               ; file descriptor (stdin)
    mov     rax,    0               ; system call number (sys_read)
    syscall                         ; call kernel
    call    Adder1

    ; Print the result
    mov     rdx,    result_msg_len  ; length of the result message
    mov     rsi,    result_msg      ; address of the result message
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall                         ; call kernel

    ; Print the result of addition
    mov     rdx,    64              ; length of the result
    mov     rsi,    result          ; address of the result
    mov     rdi,    1               ; file descriptor (stdout)
    mov     rax,    1               ; system call number (sys_write)
    syscall                         ; call kernel

    ; Exit
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

Adder1:                    ; subroutine to add numbers
    mov     rax, [num1]         ; load num1 into rax
    sub     rax, '0'            ; convert from ASCII to integer

    mov     rbx, [num2]         ; load num2 into rbx
    sub     rbx, '0'            ; convert from ASCII to integer

    add     rax, rbx            ; add rax and rbx
    add     rax, '0'            ; convert back to ASCII
    mov     [result], rax       ; store result
    ret                         ; return from subroutine

; DATA SECTION
section .bss
    num1            resb    64      ; Reserve space for first number
    num2            resb    64      ; Reserve space for second number
    result          resb    64      ; Reserve space for result

section .data
    prompt1         db  'Enter First Number: ', 0    ; String to be printed for first number
    prompt1_length  equ $ - prompt1                   ; Length of the string for first number
    prompt2         db  'Enter Second Number: ', 0   ; String to be printed for second number
    prompt2_length  equ $ - prompt2                   ; Length of the string for second number
    result_msg      db  'Result is: ', 0             ; Result message
    result_msg_len  equ $ - result_msg               ; Length of the result message
