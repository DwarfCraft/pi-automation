section .data
    newline db 0xA                      ; newline character
    hello db 'Hello, World!', 0
    prompt db 'Enter your name: ', 0
    name db 32 dup(0)                   ; buffer to store the name
    error_msg db 'Error: Invalid name', 0
    filename db 'prompts', 0            ; file name
    buffer db 64 dup(0)                 ; buffer to store file content

section .bss
    name_len resb 1                     ; variable to store the length of the name

section .text
    global _start

_start:
    ; Open the file
    mov eax, 5                          ; syscall number for sys_open
    mov ebx, filename                   ; pointer to the file name
    mov ecx, 0                          ; read-only mode
    int 0x80                            ; call kernel

    ; Check if the file was opened successfully
    cmp eax, 0
    js file_error                       ; jump if error

    ; Read the first line from the file
    mov ebx, eax                        ; file descriptor
    mov eax, 3                          ; syscall number for sys_read
    mov ecx, buffer                     ; pointer to the buffer
    mov edx, 64                         ; maximum length to read
    int 0x80                            ; call kernel

    ; Write the first line to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, buffer                     ; pointer to the buffer
    mov edx, 23                         ; length of the first line
    int 0x80                            ; call kernel

    ; Close the file
    mov eax, 6                          ; syscall number for sys_close
    int 0x80                            ; call kernel

    ; Write the prompt to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, prompt                     ; pointer to the prompt message
    mov edx, 17                         ; length of the prompt message
    int 0x80                            ; call kernel

    ; Read the name from stdin
    mov eax, 3                          ; syscall number for sys_read
    mov ebx, 0                          ; file descriptor 0 is stdin
    mov ecx, name                       ; pointer to the name buffer
    mov edx, 32                         ; maximum length of the name
    int 0x80                            ; call kernel
    mov [name_len], eax                 ; store the length of the name

    ; Check if the name is "Adam" and its length is 5 or less
    mov ecx, [name_len]
    cmp ecx, 5
    jg invalid_name                     ; jump if length is greater than 5

    mov ecx, name
    mov edx, 'Adam'
    mov esi, 4                          ; length of "Adam"
check_name:
    lodsb                               ; load byte from name
    scasb                               ; compare with byte from "Adam"
    jne invalid_name                    ; jump if not equal
    dec esi
    jnz check_name                      ; repeat for all characters

    ; Write the newline to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, newline                    ; pointer to the newline character
    mov edx, 1                          ; length of the newline character
    int 0x80                            ; call kernel

    ; Write the hello message to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, hello                      ; pointer to the hello message
    mov edx, 13                         ; length of the hello message
    int 0x80                            ; call kernel

    ; Write the newline to stdout again
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, newline                    ; pointer to the newline character
    mov edx, 1                          ; length of the newline character
    int 0x80                            ; call kernel

    ; Write the user's name to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, name                       ; pointer to the name buffer
    mov edx, [name_len]                 ; length of the name
    int 0x80                            ; call kernel

    ; Write the newline to stdout again
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, newline                    ; pointer to the newline character
    mov edx, 1                          ; length of the newline character
    int 0x80                            ; call kernel

    ; Exit the program
    mov eax, 1                          ; syscall number for sys_exit
    xor ebx, ebx                        ; exit code 0
    int 0x80                            ; call kernel

invalid_name:
    ; Write the error message to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, error_msg                  ; pointer to the error message
    mov edx, 20                         ; length of the error message
    int 0x80                            ; call kernel

    ; Exit the program with code 1
    mov eax, 1                          ; syscall number for sys_exit
    mov ebx, 1                          ; exit code 1
    int 0x80                            ; call kernel

file_error:
    ; Write the error message to stdout
    mov eax, 4                          ; syscall number for sys_write
    mov ebx, 1                          ; file descriptor 1 is stdout
    mov ecx, error_msg                  ; pointer to the error message
    mov edx, 20                         ; length of the error message
    int 0x80                            ; call kernel

    ; Exit the program with code 1
    mov eax, 1                          ; syscall number for sys_exit
    mov ebx, 1                          ; exit code 1
    int 0x80                            ; call kernel