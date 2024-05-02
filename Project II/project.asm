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

    ; Convert ASCII input to integer for first number
    xor     rdx,    rdx             ; clear rdx for later use
    mov     rsi,    num1            ; pointer to the string
    call    atoi                    ; convert ASCII to integer
    mov     r8,     rax             ; store the result in r8

    ; Convert ASCII input to integer for second number
    xor     rdx,    rdx             ; clear rdx for later use
    mov     rsi,    num2            ; pointer to the string
    call    atoi                    ; convert ASCII to integer

    ; Add the two numbers
    add     rax,    r8              ; add first number to second number

    ; Convert the sum back to ASCII
    mov     rcx,    10              ; base 10 for conversion
    mov     rbx,    rax             ; store the sum in rbx
    mov     rdi,    result          ; destination buffer for result
    mov     rsi,    result + 20     ; starting address for buffer
    mov     rax,    0               ; clear rax

.convert_loop:
    dec     rsi                     ; move buffer pointer
    xor     rdx,    rdx             ; clear rdx
    div     rcx                     ; divide rbx by 10
    add     dl,     '0'             ; convert remainder to ASCII
    mov     [rsi],  dl              ; store ASCII character in buffer
    test    rbx,    rbx             ; check if quotient is zero
    jnz     .convert_loop           ; loop until quotient is zero

    ; Calculate the length of the result
    sub     rsi,    result + 20     ; calculate length of result
    mov     rdx,    rsi             ; move length to rdx

    ; Print the result
    mov     rax,    1               ; system call number (sys_write)
    mov     rdi,    1               ; file descriptor (stdout)
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

; DATA SECTION
section .bss
    num1            resb    64      ; Reserve space for first number
    num2            resb    64      ; Reserve space for second number
    result          resb    20      ; Reserve space for result

section .data
    prompt1         db  'Enter First Number: ', 0   ; String to be printed for first number
    prompt1_length  equ $ - prompt1                  ; Length of the string for first number
    prompt2         db  'Enter Second Number: ', 0  ; String to be printed for second number
    prompt2_length  equ $ - prompt2                  ; Length of the string for second number
